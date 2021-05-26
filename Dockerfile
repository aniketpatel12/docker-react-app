FROM node:alpine as builder
WORKDIR /app
COPY package.json .
RUN apk --no-cache add curl
RUN curl -v https://registry.npmjs.com/
RUN npm install 
COPY . .
RUN npm run build

FROM nginx
EXPOSE 80

COPY --from=builder /app/build /usr/share/nginx/html 