# based on https://github.com/nownabe/docker-mecab-neologd/blob/master/Dockerfile
# and https://github.com/s-kazuki/alpine-node-yarn-install-mecab/blob/master/Dockerfile

FROM alpine:3.16.0 as build

ENV MECAB_VERSION 0.996
ENV IPADIC_VERSION 2.7.0-20070801
ENV mecab_url https://drive.google.com/uc?export=download&id=0B4y35FiV1wh7cENtOXlicTFaRUE
ENV ipadic_url https://drive.google.com/uc?export=download&id=0B4y35FiV1wh7MWVlSDBCSXZMTXM

RUN apk add --update --no-cache build-base curl git bash file sudo openssh autoconf openssl

RUN curl -SL -o mecab-${MECAB_VERSION}.tar.gz ${mecab_url} \
  && tar zxf mecab-${MECAB_VERSION}.tar.gz \
  && cd mecab-${MECAB_VERSION} \
  && ./configure --enable-utf8-only --with-charset=utf8 \
  && make \
  && make install \
  && cd

RUN curl -SL -o mecab-ipadic-${IPADIC_VERSION}.tar.gz ${ipadic_url} \
  && tar zxf mecab-ipadic-${IPADIC_VERSION}.tar.gz \
  && cd mecab-ipadic-${IPADIC_VERSION} \
  && ./configure --with-charset=utf8 \
  && make \
  && make install \
  && cd

FROM alpine:3.16.0
RUN apk add --update --no-cache openssl libstdc++ libgcc
COPY --from=build /usr/local /usr/local
