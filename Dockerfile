FROM node:20-bookworm-slim

WORKDIR /app

RUN apt-get update \
  && apt-get install -y --no-install-recommends curl ca-certificates git \
  && rm -rf /var/lib/apt/lists/*

COPY package.json ./
RUN npm install --legacy-peer-deps

COPY . .
RUN npm run build

ENV NODE_ENV=production
ENV HOST=0.0.0.0

EXPOSE 3113

CMD ["npm", "start"]
