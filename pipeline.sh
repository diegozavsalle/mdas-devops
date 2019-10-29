#!/bin/bash
set -e

# install dependencies
go get github.com/gorilla/websocket
go get github.com/labstack/echo

# cleanup
rm -rf ./build

# build
mkdir build
go build -o ./build ./src/votingapp || exit 1
cp -r ./src/votingapp/ui ./build