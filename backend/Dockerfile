# 🐳 Use official Node image - builder stage
FROM node:18-slim AS builder

# 📁 Set working directory
WORKDIR /app

# 📦 Copy package files first (for layer caching)
COPY package*.json ./

# 📥 Install dependencies - use clean install for reproducible builds
RUN npm ci --only=production

# 🐳 Final stage with smaller image
FROM node:18-slim

# Set NODE_ENV
ENV NODE_ENV=production

# 📁 Set working directory
WORKDIR /app

# Copy package files
COPY package*.json ./

# Copy node_modules from builder stage
COPY --from=builder /app/node_modules ./node_modules

# 📂 Copy application code
COPY . .

# 🌍 Expose the port your app runs on
EXPOSE 3000

# Add healthcheck
HEALTHCHECK --interval=30s --timeout=10s --start-period=5s --retries=3 \
  CMD wget -qO- http://localhost:3000/api/health || exit 1

# 🚀 Run the app
CMD ["node", "index.js"]
