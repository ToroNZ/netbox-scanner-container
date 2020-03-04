FROM python:3-alpine

ENV NBSHOME=/home/netbox
ENV NBSDIR=$NBSHOME/netbox-scanner-master

RUN adduser -D netbox -G root \
    && apk add --no-cache --update \
    nmap

RUN apk add --no-cache --update --virtual build-dependencies python3-dev openssl-dev libffi-dev gcc musl-dev make curl \
    && pip install --upgrade pip \
    && curl -Lo master.tar.gz https://github.com/ToroNZ/netbox-scanner/archive/feature/dns-vrf-addition.tar.gz \
    && mkdir -p $NBSDIR \
    && tar xf master.tar.gz --directory $NBSDIR --strip 1 \
    && rm master.tar.gz \
    && pip install -r $NBSDIR/requirements.txt \
    && apk del build-dependencies \
    && chgrp -R 0 $NBSHOME \
    && chmod -R g=u $NBSHOME \
    && chown -R netbox: $NBSHOME \
    && chmod 664 /etc/passwd

WORKDIR $NBSDIR

COPY docker-entrypoint.sh $NBSDIR

USER netbox

CMD $NBSDIR/docker-entrypoint.sh