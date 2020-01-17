docker network create votingapp_network || true

#cleanup
docker rm -f diegovotingapp || true
docker rm -f diegovotingapp-test || true

#build
docker build \
    -t diego:votingapp \
    ./src/votingapp ## context

docker run \
    --name diegovotingapp \
    --network votingapp_network \
    -p 8080:8080 \
    -d diego:votingapp

# test
docker build \
    -t diego:votingapp-test \
    ./test

docker run \
    --name diegovotingapp-test \
    --rm -e VOTINGAPP_HOST="diegovotingapp:8080" \
    --network votingapp_network -it \
    diego:votingapp-test
