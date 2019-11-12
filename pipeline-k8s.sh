#!/bin/bash
set -e

docker-compose rm -f  && \
docker-compose up --build -d && \
dockerdocker-compose push && \
kubectl apply -f votingapp.yaml && \
kubectl run mytests \
    --generator=run-pod/v1 \
    --image=paulopez/votingapp-test \
    --env VOTINGAPP_HOST=myvotingapp.votingapp \
    --rm --attach --restart=Never

## myvotingapp.votingapp (namespace)
