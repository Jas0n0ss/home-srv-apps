# Dockerfile
FROM alpine:latest
RUN apk update \
 && apk upgrade \
 && apk add --no-cache --virtual pkgs build-base pcre pcre-dev openssl openssl-dev zlib zlib-dev wget \
 && rm -rf /var/cache/apk/* \
 && ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime \
 && cd /opt && wget https://nginx.org/download/nginx-1.25.2.tar.gz \
 && tar vxzf /opt/nginx-1.25.2.tar.gz -C /opt \
 && adduser -D -s /sbin/nologin nginx \
 && cd /opt/nginx-1.25.2 \
 && ./configure \
    --user=nginx \
    --group=nginx \
    --prefix=/usr/local/nginx \
    --with-http_ssl_module \
    --with-http_gzip_static_module \
    --with-pcre  \
    --with-http_sub_module \
    --with-http_dav_module \
    --with-http_flv_module \
    --with-http_mp4_module \
    --with-http_gunzip_module \
    --with-http_gzip_static_module \
    --with-http_random_index_module \
    --with-http_secure_link_module \
    --with-http_stub_status_module \
    --with-http_v2_module \
 && make -j4 \
 && make -j4 install \
 && make clean \
 && rm -fr /opt/nginx-*  \ 
 && apk del pkgs
ENV PATH /usr/local/nginx/sbin:$PATH
ADD homepage /usr/local/nginx/html/
ADD	ngx_conf/home.conf /usr/local/nginx/conf.d/	
EXPOSE 80/tcp
ENTRYPOINT ["nginx", "-g", "daemon off;"]
