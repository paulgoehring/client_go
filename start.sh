#!/bin/sh
exec gramine-sgx client

exec gramine-sgx nodejs client.js
