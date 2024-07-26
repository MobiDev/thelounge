FROM node:21-alpine


ENV THELOUNGE_HOME "/var/opt/thelounge"
VOLUME "${THELOUNGE_HOME}"
RUN mkdir -p /home/node/app/node_modules && chown -R node:node /home/node/app
WORKDIR /home/node/app...
COPY package*.json ./
COPY --chown=node:node . .
USER root
RUN apk --update --no-cache --virtual build-deps add python3 build-base git
RUN	ln -sf python3 /usr/bin/python
RUN	yarn --frozen-lockfile
RUN	yarn build
# Expose HTTP.
ENV PORT 9000
EXPOSE ${PORT}
ENV NODE_ENV production
CMD [ "node", ".", "start" ]
