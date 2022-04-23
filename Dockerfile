FROM elixir:1.13.4-alpine
VOLUME [ "/www/db" ]
COPY ./site /www/site/
WORKDIR /www/site/
RUN mix archive.install ./hex-1.0.1.ez --force; \
mix local.rebar rebar3 ./rebar3 --force
RUN HEX_MIRROR=https://cdn.jsdelivr.net/hex mix deps.get ; mix compile
CMD [ "mix", "run", "--no-halt" ]
