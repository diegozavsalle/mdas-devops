#!/bin/bash
set -e

# install dependencies
go get github.com/gorilla/websocket
go get github.com/labstack/echo

# cleanup
pkill votingapp || ps aux | grep votingapp | awk {'print $1'} | head -1 | xargs kill -9 || true # kill votingapp process
rm -rf ./build || true # para no enviar código de error en caso que falle


# build
mkdir build
go build -o ./build ./src/votingapp || exit 1
cp -r ./src/votingapp/ui ./build

pushd build # cambiar a directorio build/
./votingapp &
popd # deshacer cambio de directorio

# test
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