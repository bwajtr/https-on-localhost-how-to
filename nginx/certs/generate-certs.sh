#!/usr/bin/env bash

# Generate a self-signed certificate for the local development environment
# This script is intended to be used with the local development environment only
mkcert -key-file key.pem -cert-file cert.pem secure.localhost``

# This will install the root certificate in the system trust store, so the self signed certificates generated
# above will be trusted by the browsers
mkcert -install