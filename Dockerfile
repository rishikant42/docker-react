FROM node:alpine AS builder
WORKDIR '/app'
COPY package.json .
RUN npm install
COPY . .
RUN npm run build

FROM nginx
EXPOSE 80
COPY --from=builder /app/build/ /usr/share/nginx/html
# why copy from /app/build ?
# Bcoz working dir is /app & the output of npm run build will go in /build
# folder so the complete path is /app/build


# why /usr/share/nginx/html?
# Bcoz this is default location for nginx to serve static content
