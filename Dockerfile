FROM node:20-bookworm-slim

WORKDIR /app

RUN apt-get update \
  && apt-get install -y --no-install-recommends curl ca-certificates tar gzip \
  && rm -rf /var/lib/apt/lists/*

# Cài iii engine
RUN curl -fsSL https://install.iii.dev/iii/main/install.sh | sh \
  && ln -sf /root/.local/bin/iii /usr/local/bin/iii

COPY package*.json ./
RUN npm install

COPY . .
RUN npm run build

ENV NODE_ENV=production
ENV III_REST_PORT=3111
ENV III_STREAMS_PORT=3112
ENV AGENTMEMORY_URL=http://127.0.0.1:3111
ENV AGENTMEMORY_VIEWER_URL=http://127.0.0.1:3113

EXPOSE 3111 3112 3113 49134

CMD ["npm", "start"]
