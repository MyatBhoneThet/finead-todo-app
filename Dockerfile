# Build Stage for Frontend
FROM node:18-alpine AS frontend-builder
WORKDIR /app/frontend
COPY TODO/todo_frontend/package*.json ./
RUN npm install
COPY TODO/todo_frontend/ ./
RUN npm run build

# Final Stage for Backend
FROM node:18-alpine
WORKDIR /app
COPY TODO/todo_backend/package*.json ./
RUN npm install
COPY TODO/todo_backend/ ./
# Copy built frontend from previous stage to the backend static/build directory
COPY --from=frontend-builder /app/frontend/build ./static/build

EXPOSE 5000
CMD ["node", "server.js"]
