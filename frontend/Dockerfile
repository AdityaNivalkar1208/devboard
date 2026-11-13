# --- Build Stage ---
FROM node:20-alpine AS build

WORKDIR /app

COPY package*.json ./
RUN npm install --legacy-peer-deps

# RUN npm list vite > /dev/null 2>&1 || npm install --no-save vite@5.4.11

COPY . .

ARG VITE_OTEL_ENABLED=false
ARG VITE_OTEL_ENVIRONMENT=dev
ARG VITE_APP_VERSION=dev
ENV VITE_OTEL_ENABLED=$VITE_OTEL_ENABLED \
    VITE_OTEL_ENVIRONMENT=$VITE_OTEL_ENVIRONMENT \
    VITE_APP_VERSION=$VITE_APP_VERSION

RUN npm run build

# --- Production Runtime Stage ---
FROM node:20-alpine AS production

WORKDIR /app

# Install only production dependencies
COPY package*.json ./
RUN npm ci --omit=dev --legacy-peer-deps

# Copy built assets from build stage
COPY --from=build /app/dist ./dist

EXPOSE 4173

CMD ["node", "./node_modules/.bin/vite", "preview", "--host", "0.0.0.0", "--port", "4173"]