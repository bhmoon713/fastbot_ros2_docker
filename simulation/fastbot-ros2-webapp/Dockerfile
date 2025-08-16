FROM ubuntu:22.04
ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y nginx \
    && rm -rf /var/lib/apt/lists/*

# Copy your webapp into nginx root (compose 'context' lets us reach it)
COPY src/fastbot_webapp/ /usr/share/nginx/html/

EXPOSE 80
CMD ["nginx","-g","daemon off;"]
