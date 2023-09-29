#### Home page Dashboard

##### Setup

```bash
git clone https://github.com/Jas0n0ss/home-srv-apps.git
cp -r home-srv-apps/homepage /WebRootPath
```

##### Docker version

```bash
# build on your own
git clone https://github.com/Jas0n0ss/home-srv-apps.git
cd home-srv-apps && docker build -t nginx:tag .
# use my image
docker pull jas0n0ss/nginx:home
docker run --name home -p 80:80 -it -d jas0n0ss/nginx:home
curl -I http://localhost
```

Just keep it in your web root path, then enjoy it. 

![image-20230929112216487](./homepage/image-20230929112216487.png)



##### Prometheus docker-compose yamls
prometheus [docker-compose common services yaml files](prometheus/README.md)

https://prometheus.io/download/

```bash
nohup ./prometheus --config.file="${BINDIR}/prometheus.yml" &
nohup /data/opt/alertmanager/alertmanager --config.file=/data/opt/alertmanager/alertmanager.yml --log.level=debug > 2>&1 &
nohup /data/opt/blackbox_exporter/blackbox_exporter --config.file=/data/opt/blackbox_exporter/blackbox.yml &
nohup /data/opt/grafana-10.1.2/bin/grafana-server -homepath /data/opt/grafana-10.1.2 &
nohup /data/opt/node_exporter/node_exporter &
nohup /data/opt/mysqld_exporter/mysqld_exporter --config.my-cnf=/data/opt/mysqld_exporter/.my.cnf &
```

```bash
BINDIR="/data/opt/prometheus"
STOP(){
	killall prometheus
}
START(){
	pidof prometheus
	if [ $? == 0 ];then
		echo "prometheus is running."
	else
		cd $BINDIR
		nohup ./prometheus --config.file="${BINDIR}/prometheus.yml" &
	fi
}
RESTART(){
	killall prometheus
	cd $BINDIR
  nohup ./prometheus --config.file="${BINDIR}/prometheus.yml" &
}

case $1 in
    stop)
        STOP
        ;;
    start)
        START
        ;;
    restart)
        RESTART
        ;;
    *)
        echo "Only supprt start|stop|restart"
        ;;
esac
```

![image-20230929112426838](./homepage/image-20230929112426838.png)

![image-20230929112615588](./homepage/image-20230929112615588.png)



