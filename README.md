Copy the binaries and dictionaries into your container to avoid bloat:

```Dockerfile
FROM ghcr.io/ruslandoga/mecab-alpine AS mecab
FROM alpine:3.16.0 AS your_app
COPY --from=mecab /usr/local/bin/mecab /usr/local/bin/mecab
# ...
```
