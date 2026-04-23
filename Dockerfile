FROM node:22-alpine

# Install OpenClaw globally
RUN npm install -g openclaw

# Create app directory
WORKDIR /app

# Copy config directly to /app
COPY openclaw.json /app/openclaw.json

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
