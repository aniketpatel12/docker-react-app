FROM node:alpine as builder
WORKDIR /app
COPY package.json .
RUN apk --no-cache add curl
RUN curl -v https://registry.npmjs.com/
RUN npm install 
COPY . .
RUN npm run build
EXPOSE 3000

FROM nginx
COPY --from=builder /app/build /usr/share/nginx/html 