#!/bin/sh

echo "Hello World!asdasd"
chmod +x ./client
exec gramine-sgx nodejs ./client.js
#exec gramine-sgx ./client
