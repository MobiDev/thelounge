FROM node:18-alpine

ENV NODE_ENV production

ENV THELOUNGE_HOME "/var/opt/thelounge"
VOLUME "${THELOUNGE_HOME}"

# Expose HTTP.
ENV PORT 9000
EXPOSE ${PORT}

ENTRYPOINT ["docker-entrypoint.sh"]
CMD ["yarn", "start"]

COPY . /thelounge

RUN mv /thelounge/docker-entrypoint.sh /usr/local/bin/docker-entrypoint.sh

WORKDIR /thelounge

# Install dependencies
RUN apk add --no-cache git

# Install thelounge.
RUN yarn --non-interactive --frozen-lockfile install --production=false && \
	yarn --non-interactive build && \
	yarn --non-interactive cache clean
