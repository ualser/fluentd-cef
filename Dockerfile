ARG FLUENTD_VERSION="1.16.6"
FROM fluentd:v${FLUENTD_VERSION}-debian-1.0

USER root

RUN apt-get update && \
    apt-get install -y build-essential libgeoip-dev libmaxminddb-dev automake autoconf libtool zlib1g-dev ruby-dev libc-dev && \
    gem install fluent-plugin-opensearch:1.1.5 && \
    fluent-gem install fluent-plugin-rewrite-tag-filter fluent-plugin-multi-format-parser && \
    fluent-gem install fluent-plugin-geoip fluent-plugin-parser_cef fluent-plugin-script && \
    apt-get remove -y build-essential automake autoconf libtool zlib1g-dev ruby-dev libmaxminddb-dev && \
    apt-get autoremove -y && \
    rm -rf /var/lib/apt/lists/* && \
    rm -rf /tmp/* /var/tmp/* /usr/lib/ruby/gems/*/cache/*.gem

USER fluent
ENTRYPOINT ["tini",  "--", "/bin/entrypoint.sh"]
CMD ["fluentd"]
