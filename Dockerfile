FROM elixir:1.13.4-alpine
VOLUME [ "/www/db" ]
COPY ./site /www/site/
WORKDIR /www/site/
RUN mix local.hex --force
RUN mix deps.get
RUN mix compile
CMD [ "mix", "run", "--no-halt" ]
