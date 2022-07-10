# based on https://qiita.com/nownabe/items/4171776aec1f05de9f28
# and https://github.com/s-kazuki/alpine-node-yarn-install-mecab/blob/master/Dockerfile

FROM alpine:3.16.0 as mecab

RUN apk add --update --no-cache build-base automake curl git bash file sudo openssh openssl

ENV MECAB_VERSION 0.996
ENV IPADIC_VERSION 2.7.0-20070801
ENV mecab_url https://drive.google.com/uc?export=download&id=0B4y35FiV1wh7cENtOXlicTFaRUE
ENV ipadic_url https://drive.google.com/uc?export=download&id=0B4y35FiV1wh7MWVlSDBCSXZMTXM

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

# # Install Neologd
# RUN git clone --depth 1 https://github.com/neologd/mecab-ipadic-neologd.git \
#   && mecab-ipadic-neologd/bin/install-mecab-ipadic-neologd -n -y \

RUN apk del curl git bash file sudo openssh \
  && rm -rf \
  mecab-${MECAB_VERSION}* \
  mecab-${IPADIC_VERSION}* \
  mecab-ipadic-neologd
