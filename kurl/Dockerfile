FROM ubuntu:18.04
## cada RUN crea una layer encima de la original de ubuntu
RUN apt-get update && apt-get install curl -y && rm -rf /var/lib/apt/lists/*

## ejecuta directamente el comando curl
ENTRYPOINT ["curl"]

