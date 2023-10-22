#!/bin/sh
exec gramine-sgx client

echo "Hello World!asdasd"

exec gramine-sgx nodejs client.js
