- node-exporter

```yaml
version: '2'
networks:
  monitor:
    driver: bridge
services:
    node-exporter:
      image: quay.io/prometheus/node-exporter
      container_name: node-exporter
      hostname: node-exporter
      restart: always
      ports:
        - "9100:9100"
      networks:
```

- redis-exporter

```yaml
version: '3'
services:
  redis-exporter:
    image: oliver006/redis_exporter
    restart: always
    command:
    - '--redis.addr=redis://10.x.x.x:6379'
    - '--redis.password=123456'
    ports:
    - '9121:9121'
```

- nginx exporter

```yaml
version: '3'
services:
  nginx-exporter-12:
    image: xxx.com/nginx-prometheus-exporter
    restart: always
    command:
    - '--nginx.scrape-uri=http://10.x.x.x:84/stub_status'
    ports:
    - '9113:9113'
  nginx-exporter-13:
    image: xxx.com/nginx-prometheus-exporter
    restart: always
    command:
    - '--nginx.scrape-uri=http://10.x.x.x:84/stub_status'
    ports:
    - '9113:9113'
```

- rocketmq_exporter

```yaml
version: '3'
services:
  rocketmq-exporter:
    image: xxx.com/rocketmq-exporter
    restart: always
    command:
    - '--rocketmq.config.namesrvAddr=10.x.x.x:9876'
    - '--rocketmq.config.rocketmqVersion=V4_8_0'
    ports:
    - '5557:5557'
```

- blackbox_exporter

```yaml
version: '3.7'
services:
  blackbox_exporter:
    container_name: blackbox_exporter
    image: xxx.com/blackbox-exporter:master
    volumes:
      - ./config.yml:/etc/blackbox_exporter/config.yml
    ports:
      - 9115:9115
    restart: always
    extra_hosts:
      - "www.163.com:172.17.3.1"
```

```yaml
# blackbox config.yaml
modules:
  http_2xx:
    prober: http
    timeout: 8s
    http:
      valid_status_codes: []
      method: GET
      fail_if_body_not_matches_regexp: []
      tls_config:
        insecure_skip_verify: true
  springboot_actuator:
    prober: http
    timeout: 8s
    http:
      valid_status_codes: []
      method: GET
      fail_if_body_not_matches_regexp: ['"status":"UP"']
      tls_config:
        insecure_skip_verify: true
```

- zookeeper-exporter

```yaml
version: '3'
services:
  zookeeper-exporter-1:
    image: carlpett/zookeeper_exporter
    restart: always
    command:
      - '-zookeeper=172.x.x.x:4181'
    ports:
      - '9141:9141'

  zookeeper-exporter-2:
    image: carlpett/zookeeper_exporter
    restart: always
    command:
      - '-zookeeper=10.x.x.x:2181'
    ports:
      - '9142:9141'
```

- kafka exporter

```yaml
version: '3'
services:
  kafka-exporter:
    image: bitnami/kafka-exporter:latest
    command:
      - '--kafka.server=192.168.1.x:9092'
      - '--kafka.server=192.168.1.x:9092'
    restart: always
    port:
      - "9308:9308"
```

- elasticsearch-exporter

```yaml
version: '3'
services:
  elasticsearch-exporter:
    image: bitnami/elasticsearch-exporter:latest
    commmand:
      - '--es.uri:http://elasticsearch:9200'
    restart: always
    ports:
      - "9114:9114"
```

- mysql exporter

```yaml
services:
    mysqld-exporter:
      image: prom/mysqld-exporter
      container_name: mysqld-exporter
      hostname: mysqld-exporter
      restart: always
      ports:
        - "9104:9104"
      environment:
        - DATA_SOURCE_NAME=user:password@(192.168.2.169:3306)/
```
