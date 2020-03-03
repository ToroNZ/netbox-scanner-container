FROM python:3-alpine

ENV NBSHOME=/home/netbox
ENV NBSDIR=$NBSHOME/netbox-scanner-master

RUN adduser -D netbox -G root \
    && apk add --no-cache --update \
    nmap \
    curl \
    unzip

RUN apk add --no-cache --update --virtual build-dependencies python3-dev openssl-dev libffi-dev gcc musl-dev make \
    && pip install --upgrade pip \
    && curl -LO https://github.com/forkd/netbox-scanner/archive/master.zip \
    && unzip master.zip -d $NBSHOME \
    && rm master.zip \
    && cd $NBSDIR \
    && pip install -r requirements.txt \
    && apk del build-dependencies \
    && chgrp -R 0 $NBSHOME \
    && chmod -R g=u $NBSHOME \
    && chown -R netbox: $NBSHOME \
    && chmod 664 /etc/passwd

WORKDIR $NBSDIR

COPY docker-entrypoint.sh $NBSDIR

USER netbox

CMD $NBSDIR/docker-entrypoint.sh