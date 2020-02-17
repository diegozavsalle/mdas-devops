docker network create votingapp || true

#cleanup
docker rm -f myvotingapp || true

#build
docker build \
    -t paulopez/votingapp \
    ./src/votingapp

docker run \
    --name myvotingapp \
    --network votingapp \
    -p 8080:80 \
    -d paulopez/votingapp

# test
docker build \
    -t paulopez/votingapp-test \
    ./test

docker run \
    --rm -e VOTINGAPP_HOST="myvotingapp" \
    --network votingapp \
    paulopez/votingapp-test

#delivery
docker push paulopez/votingapp