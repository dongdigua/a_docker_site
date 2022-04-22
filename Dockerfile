FROM elixir:1.13.4-alpine
RUN sed -i 's/dl-cdn.alpinelinux.org/mirrors.tuna.tsinghua.edu.cn/g' /etc/apk/repositories; \
apk add git
VOLUME [ "/www/db" ]
COPY ./site /www/site/
WORKDIR /www/site/
RUN HEX_MIRROR=https://cdn.jsdelivr.net/hex mix local.hex --force
RUN HEX_MIRROR=https://cdn.jsdelivr.net/hex mix local.rebar --force
RUN HEX_MIRROR=https://cdn.jsdelivr.net/hex mix deps.get ; mix compile
CMD [ "mix", "run", "--no-halt" ]
