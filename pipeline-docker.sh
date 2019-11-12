#!/bin/bash
set -e

# cleanup
cleanup(){
    docker rm -f myvotingapp
}

# build
build(){
    docker build \
        -t paulopez/votingapp \
        .src/votingapp

    docker run \
        --name myredis \
        --network votingapp \
        -d redis

    docker run \
        --name myvotingapp \
        --network votingapp \
        -p 8080:80 \
        -e REDIS="myredis:6379" \
        -d paulopez/votingapp

    # docker run --name myvotingapp -v $(pwd)/build:/app -w /app -p 8080:80 -d ubuntu ./vottingapp
    docker run --name myvotingapp -p 8080:80 -d paulopez/votingapp
}

# test
test(){
    curl --url http://localhost/vote \
        --request POST \
        --data '{"topics":["Dev","Ops"]}' \
        --header "Content-Type: application/json"

    curl --url http://localhost/vote \
        --request PUT \
        --data '{"topic":"Dev"}' \
        --header "Content-Type: application/json"

    expectedWinner="Dev"
    winner=$(curl --url http://localhost/vote \
        --request DELETE \
        --header "Content-Type: application/json" | jq -r '.winner')

    echo "Winner IS $winner"

    if [ "$expectedWinner" == "$winner" ]; then
        echo "Test passed"
        exit 0
    else
        echo "Test failed"
        exit 1
    fi
}

## ejecución de funciones
cleanup || true ## para que no pare cuando ejecute cleanup
build
test

# delivery
# docker push paulopez/votingapp
