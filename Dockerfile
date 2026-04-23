FROM node:22-alpine

# Install OpenClaw globally
RUN npm install -g openclaw

# Create app directory
WORKDIR /app

# Copy package files
COPY package.json ./

# Install dependencies (for any native modules)
RUN npm install --ignore-scripts

# Copy config (will be mounted or baked in)
COPY openclaw.json /app/config/openclaw.json
COPY start.sh /app/start.sh

# Make start script executable
RUN chmod +x /app/start.sh

# Expose gateway port
EXPOSE 18789

# Environment variables for Railway
ENV NODE_ENV=production
ENV PORT=18789

# Health check
HEALTHCHECK --interval=30s --timeout=10s --start-period=60s --retries=3 \
  CMD wget -qO- http://localhost:18789/health || exit 1

# Run the start script
CMD ["/app/start.sh"]
