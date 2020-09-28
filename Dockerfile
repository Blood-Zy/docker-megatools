FROM alpine:3.12 as build-env

RUN apk add --update build-base libcurl curl-dev asciidoc openssl-dev glib-dev \
    glib libtool automake autoconf meson git docbook2x

RUN git clone https://megous.com/git/megatools \
	&& cd megatools \
	&& meson b \
	&& ninja -C b \
	&& ninja -C b install


FROM python:3.8.6-alpine3.12

RUN apk add --update glib libcurl

COPY --from=build-env /usr/local/bin/* /usr/local/bin/