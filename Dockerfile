# Stage 1: Build the app
FROM node:16-alpine AS builder
WORKDIR /app
# Copy package.json and package-lock.json (if available)
COPY package*.json ./
# Install dependencies
RUN npm install
# Copy the rest of the files
COPY . .
# Build the app (this will generate a dist folder)
RUN npm run build

# Stage 2: Serve the app with Nginx
FROM nginx:alpine
# Remove default Nginx website
RUN rm -rf /usr/share/nginx/html/*
# Copy build output to Nginx's html directory
COPY --from=builder /app/dist /usr/share/nginx/html
# Expose port 3000
EXPOSE 3000
# Instruct Nginx to listen on port 3000 by copying a custom config
COPY nginx.conf /etc/nginx/conf.d/default.conf

CMD ["nginx", "-g", "daemon off;"]