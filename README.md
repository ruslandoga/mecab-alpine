Copy the binaries and dictionaries into your container to avoid bloat:

```Dockerfile
FROM ghcr.io/ruslandoga/mecab-alpine:master AS mecab
FROM alpine:3.16.0 AS your_app
RUN apk add --update --no-cache openssl libstdc++ libgcc
COPY --from=mecab /usr/local /usr/local
# now `mecab` is available in `your_app`
```

```console
> docker run -ti --rm --platform linux/amd64 ghcr.io/ruslandoga/mecab-alpine:master ash

# which mecab
/usr/local/bin/mecab

# mecab
昨日すき焼きを食べました
昨日	名詞,副詞可能,*,*,*,*,昨日,キノウ,キノー
すき焼き	名詞,一般,*,*,*,*,すき焼き,スキヤキ,スキヤキ
を	助詞,格助詞,一般,*,*,*,を,ヲ,ヲ
食べ	動詞,自立,*,*,一段,連用形,食べる,タベ,タベ
まし	助動詞,*,*,*,特殊・マス,連用形,ます,マシ,マシ
た	助動詞,*,*,*,特殊・タ,基本形,た,タ,タ
EOS
```
