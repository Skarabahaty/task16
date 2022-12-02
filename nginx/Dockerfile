FROM nginx:alpine
RUN apk update && apk upgrade && apk add nginx-mod-http-image-filter
COPY ./nginx.conf /etc/nginx/nginx.conf
COPY home /home
EXPOSE 8080