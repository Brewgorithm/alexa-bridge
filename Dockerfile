FROM node:8-alpine

# Install cURL for healthcheck
RUN apk add --update curl && \
    rm -rf /var/cache/apk/*

ENV PORT=8080
EXPOSE $PORT

ENV DIR=/usr/src/service
WORKDIR $DIR
COPY package.json package.json
COPY package-lock.json package-lock.json
COPY node_modules node_modules
COPY . .

HEALTHCHECK --interval=5s \
            --timeout=5s \
            --retries=6 \
            CMD curl -fs http://localhost:$PORT/ || exit 1

CMD ["node", "server.js"]
