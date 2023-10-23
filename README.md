

chmod 777 start.sh

sudo docker build --no-cache -t trynodejscont22 .

docker run --device=/dev/sgx/enclave:/dev/sgx/enclave --device=/dev/sgx/enclave:/dev/sgx_enclave --device=/dev/sgx_provision:/dev/sgx_provision -it trynodejscont22