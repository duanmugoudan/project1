FROM 10.0.0.31:80/library/node:16.4 AS build
WORKDIR /app

COPY package*.json ./
RUN mkdir -p /app/node_modules/.cache && chmod -R 777 /app
RUN npm ci

COPY . .
RUN npm run build

ARG BACKEND_URL
ENV VUE_APP_BASEURL=$BACKEND_URL

FROM 10.0.0.31:80/library/nginx:alpine
COPY --from=build /app/dist /usr/share/nginx/html
COPY nginx.conf /etc/nginx/conf.d/default.conf
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
