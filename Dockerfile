# Stage one
FROM node:18-alpine As development

LABEL \
 org.opencontainers.image.vendor="Official Docker Image for Node.js" \
 org.opencontainers.image.title="Example App Pet Cats in Node.js" \
 org.opencontainers.image.version="1.0.0" \
 org.opencontainers.image.url="https://hub.docker.com/r/erivando/app-pet-cats-node" \
 org.opencontainers.image.source="https://github.com/erivandosena/pet-cats-node.git" \
 org.opencontainers.image.licenses="MIT" \
 org.opencontainers.image.author="erivandosena@gmail.com" \
 org.opencontainers.image.maintainer="Erivando Sena"

##############################
# Build Development
##############################

WORKDIR /opt/app

COPY --chown=node:node index.js package*.json ./

RUN npm install

COPY --chown=node:node . .

USER node

# Stage two
FROM node:18-alpine As build

WORKDIR /opt/app

COPY --chown=node:node index.js package*.json ./
COPY --chown=node:node --from=development /opt/app/node_modules ./node_modules

COPY --chown=node:node . .

ENV NODE_ENV production

RUN npm ci --omit=dev && npm cache clean --force

USER node

##############################
# Build Production
##############################

FROM node:18-alpine As production

WORKDIR /opt/app

COPY --chown=node:node --from=build /opt/app/index.js ./index.js
COPY --chown=node:node --from=build /opt/app/node_modules ./node_modules
COPY --from=build /opt/app/ /opt/app/

EXPOSE 3000

CMD [ "node", "index.js" ]