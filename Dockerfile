FROM garland/aws-cli-docker

RUN apk --no-cache update && \
    apk --no-cache add postgresql && \
    rm -rf /var/cache/apk/*

ADD run.sh /data/run.sh

CMD ["/data/run.sh"]
