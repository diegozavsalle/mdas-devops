#!/bin/bash
set -e

# install deps
deps(){
    # install go manually
    go get github.com/gorilla/websocket
    go get github.com/labstack/echo
}

# cleanup
cleanup(){
    # argumento cambiado al ejecutarlo en ubuntu de $1 a $2
    pkill votingapp || ps aux | grep votingapp | awk {'print $1'} | head -1 | xargs kill -9
    rm -rf build
}

# build 
build(){
    mkdir build
    go build -o ./build ./src/votingapp 
    cp -r ./src/votingapp/ui ./build

    pushd build
    ./votingapp &
    popd
}

retry(){
    n=0
    interval=5
    retries=3
    $@ && return 0
    until [ $n -ge $retries ]
    do
        n=$(($n+1))
        echo "Retrying...$n of $retries, wait for $interval seconds"
        sleep $interval
        $@ && return 0
    done

    return 1
}

# test
test() {
    python3 testIT.py
}

deps
cleanup || true
build
retry test
