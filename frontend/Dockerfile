# Stage 1: Build the Application
FROM node:alpine AS builder

WORKDIR /app
# Cache and Install dependencies
COPY . .
RUN npm install 
# Expose the port
EXPOSE 3000
# Set the entrypoint command to start the application
CMD ["npm", "start"]

