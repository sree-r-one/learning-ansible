FROM node:18 AS builder
WORKDIR /app

# Copy package files first for better layer caching
COPY package*.json ./
RUN npm ci

# Copy source code
COPY . .

# Build the application
RUN npm run build

# Use nginx for serving the application
FROM nginx:alpine
COPY --from=builder /app/dist /usr/share/nginx/html

# Add custom nginx configuration
COPY nginx.conf /etc/nginx/conf.d/default.conf

# Expose port 80
EXPOSE 80

# Health check
HEALTHCHECK --interval=30s --timeout=10s --start-period=5s --retries=3 \
  CMD wget -qO- http://localhost:80 || exit 1

# Start nginx
CMD ["nginx", "-g", "daemon off;"]
