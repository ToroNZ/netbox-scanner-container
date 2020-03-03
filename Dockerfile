FROM python:3-alpine

RUN apk add --no-cache --update \
    nmap \
    curl \
    unzip

RUN apk add --no-cache --update --virtual build-dependencies python3-dev openssl-dev libffi-dev gcc musl-dev make \
    && pip install --upgrade pip \
    && curl -LO https://github.com/forkd/netbox-scanner/archive/master.zip \
    && unzip master.zip \
    && cd netbox-scanner-master \
    && pip install -r requirements.txt \
    && apk del build-dependencies

WORKDIR /netbox-scanner-master

CMD ["python", "netbox-scanner/nbscanner"]
