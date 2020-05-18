FROM python:3.7-alpine

RUN apk update && \
    pip install b2 && \
    apk add mysql-client

COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT ["entrypoint.sh"]
