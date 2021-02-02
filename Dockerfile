FROM alpine:3.12

RUN apk add --update --virtual build-deps go git musl-dev && \
    go get github.com/mdlayher/unifi_exporter/cmd/unifi_exporter

FROM alpine:3.12
RUN apk add --no-cache dumb-init
EXPOSE 9130
COPY --from=0 /root/go/bin/unifi_exporter /bin/unifi_exporter
COPY run.sh /run.sh
USER nobody
ENTRYPOINT ["dumb-init", "--"]
CMD ["/run.sh"]
