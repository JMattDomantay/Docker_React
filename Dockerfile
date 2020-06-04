# base image tagged as builder
FROM node:alpine as builder

# Work directory
WORKDIR '/app'

# Copy dependency file from local machine
COPY package.json . 

# Install dependencies
RUN npm install

# Copy every fucking thing from the local machine 
COPY  . .

# Execute server start up command 
RUN npm run build 

# /app/build ===> production face of the project

# start the 2nd phase

FROM nginx

# Copy /app/build from phase 1
COPY --from=builder /app/build /usr/share/nginx/html

# we don't have to start anything because as default upon start up is nginx is already running