FROM debian:bullseye

RUN apt update -y && apt upgrade -y && \
    apt install -y nginx openssl

RUN mkdir -p /etc/nginx/ssl /var/run/nginx

RUN openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
    -out /etc/nginx/ssl/inception.crt \
    -keyout /etc/nginx/ssl/inception.key \
    -subj "/C=FR/ST=IDF/L=Paris/O=42/OU=42/CN=epolitze.42.fr/UID=epolitze"

COPY conf/nginx.conf /etc/nginx/nginx.conf

RUN chmod 755 /etc/nginx/nginx.conf && \
    chmod 600 /etc/nginx/ssl/inception.key && \
    chmod 644 /etc/nginx/ssl/inception.crt

CMD ["nginx", "-g", "daemon off;"]