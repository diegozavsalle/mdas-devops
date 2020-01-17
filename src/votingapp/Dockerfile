######## BUILDER #########
FROM golang AS builder

RUN go get github.com/gorilla/websocket && \
    go get github.com/labstack/echo && \
    go get github.com/go-redis/redis

COPY . .

#compilado para alpine
RUN CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build -a \
    -tags netgo -ldflags '-w -extldflags "-static"' -o /build/votingapp && \
    cp -r ui /build


######## RUNTIME #########
FROM alpine:3.10.3
RUN apk add bash

WORKDIR /app
COPY --from=builder /build .

EXPOSE 8080
ENTRYPOINT [ "./votingapp" ]
