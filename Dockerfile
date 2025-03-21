FROM ghcr.io/calyptia/fluentd:v1.14.6-debian-1.0

USER root

RUN apk add libc-dev
RUN gem install fluent-plugin-opensearch
RUN fluent-gem install fluent-plugin-rewrite-tag-filter fluent-plugin-multi-format-parser fluent-plugin-parser_cef

USER fluent
ENTRYPOINT ["tini",  "--", "/bin/entrypoint.sh"]
CMD ["fluentd"]
