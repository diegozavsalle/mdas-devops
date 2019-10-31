#!/bin/bash
set -e

# install dependencies
dependencies(){
    go get github.com/gorilla/websocket
    go get github.com/labstack/echo
}

# cleanup
cleanup(){
    docker rm -f myvotingapp
    rm -rf ./build || true # para no enviar código de error en caso que falle
}

# build
build(){
    mkdir build
    go build -o ./build ./src/votingapp || exit 1
    cp -r ./src/votingapp/ui ./build
    
    docker build -f src/votingapp/Dockerfile -t paulopez/votingapp
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
dependencies
cleanup
GOOS=linux build
test


# delivery
docker push paulopez/votingapp