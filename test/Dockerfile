FROM alpine:3.10.3

RUN apk add --no-cache --update \
    bash \
    linux-headers \
    python3 \
    && pip3 install requests

COPY test.sh .
COPY testIT.py .
RUN chmod +x test.sh

ENTRYPOINT ["bash", "-c", "./test.sh" ]