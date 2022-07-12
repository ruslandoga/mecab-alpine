Copy the binaries and dictionaries into your container to avoid bloat:

```Dockerfile
FROM ghcr.io/ruslandoga/mecab-alpine:mecab AS mecab
FROM alpine:3.16.0 AS your_app
RUN apk add --update --no-cache openssl libstdc++ libgcc
COPY --from=mecab /usr/local /usr/local
# now `mecab` is available in `your_app`
```

```console
> docker images

REPOSITORY                        TAG             IMAGE ID       CREATED         SIZE
ghcr.io/ruslandoga/mecab-alpine   mecab-neologd   9bf7eaab8fd2   5 minutes ago   975MB
ghcr.io/ruslandoga/mecab-alpine   mecab           432365fff470   44 hours ago    64.1MB
```

```console
> docker run -ti --rm --platform linux/amd64 ghcr.io/ruslandoga/mecab-alpine:mecab ash

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

```console
> docker run -ti --rm --platform linux/amd64 ghcr.io/ruslandoga/mecab-alpine:mecab-neologd ash

# mecab -d /usr/local/lib/mecab/dic/mecab-ipadic-neologd
昨日すき焼きを食べました
昨日	名詞,副詞可能,*,*,*,*,昨日,キノウ,キノー
すき焼き	名詞,一般,*,*,*,*,すき焼き,スキヤキ,スキヤキ
を	助詞,格助詞,一般,*,*,*,を,ヲ,ヲ
食べ	動詞,自立,*,*,一段,連用形,食べる,タベ,タベ
まし	助動詞,*,*,*,特殊・マス,連用形,ます,マシ,マシ
た	助動詞,*,*,*,特殊・タ,基本形,た,タ,タ
EOS
```
