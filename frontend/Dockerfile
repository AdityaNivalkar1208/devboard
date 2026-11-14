FROM node:22-bookworm-slim AS build

WORKDIR /app

# Install exact dependencies from lockfile
COPY package*.json ./
RUN npm ci --legacy-peer-deps

# Copy app source and build
COPY . .
RUN npm run build

# Runtime stage: install only production-like runtime deps and keep image small
FROM node:22-bookworm-slim AS runtime

WORKDIR /app

# Copy package manifests first
COPY package*.json ./

# Install only runtime dependencies needed by Vite preview
# This avoids shipping the full dev toolchain into the final image
RUN npm ci --omit=dev --legacy-peer-deps

# Install Vite runtime only (if needed by preview)
RUN npm install vite@5.4.11 --no-save

# Copy built app
COPY --from=build /app/dist ./dist
COPY vite.preview.config.js ./vite.config.js

EXPOSE 4173

# Run Vite preview from the runtime image
CMD ["node", "./node_modules/vite/bin/vite.js", "preview", "--host", "0.0.0.0", "--port", "4173"]