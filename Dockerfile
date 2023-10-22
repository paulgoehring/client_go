#FROM alpine/git:latest AS pull_marblerun
#RUN git clone --depth=1 https://github.com/edgelesssys/marblerun.git /marblerun


FROM alpine/git:latest AS pull_gramine
RUN git clone https://github.com/paulgoehring/client_go /gramine


#FROM ghcr.io/edgelesssys/edgelessrt-dev:latest AS build-premain
#COPY --from=pull_marblerun /marblerun /premain
#WORKDIR /premain/build
#RUN cmake -DCMAKE_BUILD_TYPE=RelWithDebInfo ..
#RUN make premain-libos

FROM gramineproject/gramine:v1.5 AS release

ENV DEBIAN_FRONTEND noninteractive
RUN apt-get update && apt-get install -y \
    wget \
    libssl-dev \
    libsgx-quote-ex-dev \
    libsgx-dcap-default-qpl \
    build-essential \
    libprotobuf-c-dev \
    nodejs \
    && apt-get clean -y && apt-get autoclean -y && apt-get autoremove -y

ARG GOLANG_VERSION=1.20.4
RUN wget https://go.dev/dl/go${GOLANG_VERSION}.linux-amd64.tar.gz && \
    rm -rf /usr/local/go && tar -C /usr/local -xzf go${GOLANG_VERSION}.linux-amd64.tar.gz && \
    rm go${GOLANG_VERSION}.linux-amd64.tar.gz
ENV PATH="${PATH}:/usr/local/go/bin"

COPY --from=pull_gramine /gramine /gramine
COPY ./client.manifest.template ./start.sh /gramine

WORKDIR /gramine/

RUN gramine-sgx-gen-private-key
RUN make clean && make SGX=1

ENTRYPOINT [ "/gramine/start.sh" ]