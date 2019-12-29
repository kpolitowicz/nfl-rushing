### BUILD STAGE
FROM bitwalker/alpine-elixir-phoenix:1.9.2 as builder
RUN mkdir /app

WORKDIR /app

RUN mix local.hex --force
RUN mix local.rebar --force

# Set the build environment variables
ENV MIX_ENV=prod \
    SECRET_KEY_BASE=NmPWwKEDrSiXlVhOx2aWkCweM04Ei9CYhkmngipgN5JfXniOi2Qlmk5EB3GL5WMr

# Copy relevant files
COPY config ./config
COPY lib ./lib
COPY rel ./rel
COPY assets ./assets
COPY rushing.json .
COPY mix.exs .
COPY mix.lock .

RUN mix do deps.get, deps.compile
RUN npm install --prefix assets
RUN npm run deploy --prefix ./assets

# Build assets in production mode:
# WORKDIR /app/apps/montreal_elixir_web/assets

# Remove any existing node modules that exist from the host platform. This will cause problems
# if we have modules from the host with OS specific extensions.
# RUN rm -rf ./node_modules/*
# RUN npm install && ./node_modules/webpack/bin/webpack.js --mode production

# WORKDIR /app
RUN mix phx.digest

WORKDIR /app
RUN mix release

### RELEASE STAGE
FROM elixir:1.9-alpine AS app

# Expose app port
EXPOSE 4000

# Copy over the build artifact from the previous step
WORKDIR /app
COPY --from=builder /app/_build .
COPY --from=builder /app/rushing.json .

# This is only to find rushing.json file in prod
WORKDIR /app/lib/nfl_rushing

# Start the app
CMD ["../../prod/rel/nfl_rushing/bin/nfl_rushing", "start"]
