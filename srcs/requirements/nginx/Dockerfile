FROM debian:bullseye

RUN apt update -y && apt upgrade -y && \
    apt install -y nginx openssl

RUN mkdir -p /etc/nginx/ssl /var/run/nginx

# Here we generate a self-signed ssl certificate
RUN openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
    -out /etc/nginx/ssl/inception.crt \
    -keyout /etc/nginx/ssl/inception.key \
    -subj "/C=FR/ST=ARA/L=Lyon/O=\"42 Lyon Auvergne Rhone-Alpes\"/OU=42/CN=epolitze.42.fr/UID=epolitze"
# C = Country
# ST = State
# L = Location
# O = Organization
# OU = Organizational Unit
# CN = Common Name (Server domain)
# UID = User ID 

COPY conf/nginx.conf /etc/nginx/nginx.conf

RUN chmod 755 /etc/nginx/nginx.conf && \
    chmod 600 /etc/nginx/ssl/inception.key && \
    chmod 644 /etc/nginx/ssl/inception.crt

CMD ["nginx", "-g", "daemon off;"]