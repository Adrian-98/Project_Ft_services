#!/bin/sh

# Kill all processes.
minikube delete
killall -TERM kubectl minikube VBoxHeadless

# Start minikube.
minikube start --vm-driver=virtualbox --cpus 3 --memory=3000mb

# Use the docker daemon from minikube.
eval $(minikube docker-env)

# Build docker images.
# ""> /dev/null 2>&1" redirects the output of your program to /dev/null. Include both the Standard Error and Standard Out
# ">" is for redirect. "/dev/null" is a black hole where any data sent, will be discarded
# "2" is the file descriptor for Standard Error. "1" is the file descriptor for Standard Out.
# "&" is the symbol for file descriptor (without it, the following 1 would be considered a filename).
echo "${GREEN}Docker build init${END}"
docker build -t my_nginx srcs/nginx >> logs.txt
docker build -t my_wordpress srcs/wordpress >> logs.txt
docker build -t my_mysql srcs/mysql >> logs.txt
docker build -t my_phpmyadmin srcs/phpmyadmin >> logs.txt
docker build -t my_ftps srcs/ftps >> logs.txt
docker build -t my_grafana srcs/grafana >> logs.txt
docker build -t my_influxdb srcs/influxdb >> logs.txt
echo "${BLUE}Docker build completed${END}"

# Apply yaml resources.
echo "${GREEN}Deploy init${END}"
kubectl apply -f https://raw.githubusercontent.com/metallb/metallb/v0.9.3/manifests/namespace.yaml
kubectl apply -f https://raw.githubusercontent.com/metallb/metallb/v0.9.3/manifests/metallb.yaml
kubectl create secret generic -n metallb-system memberlist  --from-literal=secretkey="$(openssl rand -base64 128)"
kubectl apply -f srcs/config.yaml
kubectl apply -f srcs/nginx.yaml
kubectl apply -f srcs/mysql.yaml
kubectl apply -f srcs/ftps.yaml
kubectl apply -f srcs/phpmyadmin.yaml
kubectl apply -f srcs/wordpress.yaml
kubectl apply -f srcs/grafana.yaml
kubectl apply -f srcs/influxdb.yaml
kubectl apply -f srcs/grafana-config.yaml
echo "${BLUE}Deploy completed${END}"


# Enable addons.
minikube addons enable metrics-server
minikube addons enable dashboard
minikube addons enable ingress
minikube addons enable metrics-server

# Open dashboard.
minikube dashboard