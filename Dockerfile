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
    git \
    && apt-get clean -y && apt-get autoclean -y && apt-get autoremove -y


ARG GOLANG_VERSION=1.20.4
RUN wget https://go.dev/dl/go${GOLANG_VERSION}.linux-amd64.tar.gz && \
    rm -rf /usr/local/go && tar -C /usr/local -xzf go${GOLANG_VERSION}.linux-amd64.tar.gz && \
    rm go${GOLANG_VERSION}.linux-amd64.tar.gz
ENV PATH="${PATH}:/usr/local/go/bin"


RUN git clone https://github.com/paulgoehring/client_go /app/


COPY ./nodejs.manifest.template ./Makefile ./client.js ./start.sh /app/
COPY ./* /app/

WORKDIR /app/

RUN gramine-sgx-gen-private-key

RUN make SGX=1


#ENTRYPOINT [ "/usr/bin/nodejs", "client.js" ]
ENTRYPOINT [ "/usr/bin/sh", "start.sh" ]