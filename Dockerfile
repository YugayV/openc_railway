FROM node:22-alpine

# Install OpenClaw globally
RUN npm install -g openclaw

# Create config directory
RUN mkdir -p /app/config

# Copy config
COPY openclaw.json /app/config/openclaw.json

# Set config path via environment variable
ENV OPENCLAW_CONFIG=/app/config/openclaw.json

# Create data directory for OpenClaw workspace/state
RUN mkdir -p /app/workspace

WORKDIR /app

# Expose gateway port
EXPOSE 18789

# Environment variables
ENV NODE_ENV=production
ENV PORT=18789

# Health check
HEALTHCHECK --interval=30s --timeout=10s --start-period=60s --retries=3 \
  CMD wget -qO- http://localhost:18789/health || exit 1

# Run OpenClaw gateway in foreground mode
CMD ["openclaw", "gateway", "run"]
