FROM node:20-alpine AS build

WORKDIR /app

# Update global npm to patch embedded dependencies like tar
RUN npm install -g npm@latest

COPY package*.json ./
RUN npm install --legacy-peer-deps

COPY . .
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