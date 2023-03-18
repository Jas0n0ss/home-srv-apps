# home-srv-apps
```bash
02:13:45 root@homesrv docker-app ±|main ✗|→ docker-compose -f docker-apps.yml ps
  Name                 Command               State                                                              Ports
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
alist       /entrypoint.sh                   Up      0.0.0.0:5244->5244/tcp,:::5244->5244/tcp
aria2-pro   /init                            Up      0.0.0.0:6800->6800/tcp,:::6800->6800/tcp, 0.0.0.0:6888->6888/tcp,:::6888->6888/tcp, 0.0.0.0:6888->6888/udp,:::6888->6888/udp
ariang      /darkhttpd /AriaNg --port  ...   Up
jellyfin    /init                            Up      0.0.0.0:8096->8096/tcp,:::8096->8096/tcp, 8920/tcp
sptest      docker-php-entrypoint bash ...   Up      80/tcp, 0.0.0.0:8010->8010/tcp,:::8010->8010/tcp
xunlei      /xunlei/xlp syno                 Up      0.0.0.0:2345->2345/tcp,:::2345->2345/tcp
02:13:51 root@homesrv docker-app ±|main ✗|→ docker-compose -f monitor.yml ps
     Name                    Command                  State                              Ports
---------------------------------------------------------------------------------------------------------------------
cadvisor          /usr/bin/cadvisor -logtostderr   Up (healthy)   0.0.0.0:8080->8080/tcp,:::8080->8080/tcp
grafana           /run.sh                          Up             0.0.0.0:3000->3000/tcp,:::3000->3000/tcp
mysql             docker-entrypoint.sh mysqld      Up             0.0.0.0:3306->3306/tcp,:::3306->3306/tcp, 33060/tcp
nginx-exporter    /usr/bin/nginx-prometheus- ...   Up             0.0.0.0:9113->9113/tcp,:::9113->9113/tcp
node-exporter     /bin/node_exporter               Up             0.0.0.0:9100->9100/tcp,:::9100->9100/tcp
prometheus        /bin/prometheus --config.f ...   Up             0.0.0.0:9090->9090/tcp,:::9090->9090/tcp
vmware_exporter   /usr/local/bin/vmware_exporter   Up             0.0.0.0:9272->9272/tcp,:::9272->9272/tcp
```
# nginx conf
```Nginx
server {
  listen 80;
  server_name v.bo.ms;


  # Enable Gzip compression for faster page load times
  gzip on;
  gzip_types text/plain text/css application/json application/javascript text/xml application/xml application/xml+rss text/javascript;

  # Set caching headers to improve performance
  add_header Cache-Control "public, max-age=86400";

  # Redirect all HTTP requests to HTTPS (optional, if you want to force HTTPS)
  # if ($scheme != "https") {
  #   return 301 https://$server_name$request_uri;
  # }

  # Proxy requests to the backend server
  location / {
    proxy_pass http://127.0.0.1:8096;
    proxy_set_header Host $host;
    proxy_set_header X-Real-IP $remote_addr;
    proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
    proxy_set_header X-Forwarded-Proto $scheme;
    proxy_redirect off;
  }

  # Security headers to improve site security
  add_header X-Content-Type-Options nosniff;
  add_header X-Frame-Options "SAMEORIGIN";
  add_header X-XSS-Protection "1; mode=block";
  add_header Referrer-Policy "strict-origin";

  # Enable HSTS (HTTP Strict Transport Security) to force all requests to use HTTPS (optional, if you want to enable HTTPS in the future)
  # add_header Strict-Transport-Security "max-age=31536000; includeSubDomains" always;
}
```
```bash
02:20:39 root@homesrv docker-app ±|main|→ curl -I http://v.bo.ms
HTTP/1.1 302 Found
Server: openresty/1.21.4.1
Date: Sat, 18 Mar 2023 18:20:47 GMT
Connection: keep-alive
Location: /web/index.html
```
