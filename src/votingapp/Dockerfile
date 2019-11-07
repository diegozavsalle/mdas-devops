#================  begin BUILDER ==================#
FROM golang AS builder
COPY . .
## dependencies
## si se ponen las dependencias en una línea, se vuelve a pedir, y no obtiene datos de caché
RUN go get github.com/gorilla/websocket
RUN go get github.com/labstack/echo

RUN go build -o /build/votingapp && \
    cp -r ui /build


#================  begin RUNTIME ==================#
FROM ubuntu:18.04
WORKDIR /app
## COPY --from={stage} {source dir} {target dir}
COPY --from=builder build .
##RUN apt-get update && apt-get install golang -y && rm -rf /var/lib/apt/lists/*
ENTRYPOINT [ "./votingapp" ]

