#!/bin/bash
set -e

# cleanup
docker-compose rm -f || true
# build
docker-compose up --build -d
# test
docker-compose run --rm mytest && \
echo "GREEN" || echo "RED"
# delivery
# docker-compose push
