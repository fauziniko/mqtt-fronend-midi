# Stage 1: Build the app
FROM node:20.11.1-alpine3.19 AS build
WORKDIR /app
# Copy package.json
COPY package.json ./
# Install dependencies
RUN yarn install
# Set PATH environment variable
ENV PATH /app/node_modules/.bin:$PATH
# Copy the rest of the files
COPY . .
# Build the app (this will generate a dist folder)
RUN yarn run build

# Stage 2: Serve the app with Nginx
FROM nginx:1.25.4-alpine3.18
# Remove default Nginx website
RUN rm -rf /usr/share/nginx/html/*
# Copy build output to Nginx's html directory
COPY --from=build /app/dist /var/www/html/
# Expose port 3000
EXPOSE 3000
# Instruct Nginx to listen on port 3000 by copying a custom config
COPY ./nginx.conf /etc/nginx/conf.d/default.conf

ENTRYPOINT ["nginx", "-g", "daemon off;"]