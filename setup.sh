
# #!/bin/bash

# # Functions
# clean() {
# 	printf "🗑  Cleaning all services...\n"

# 	kubectl delete -f srcs/ftps.yaml >> logs.txt
# 	kubectl delete -f srcs/mysql.yaml >> logs.txt
# 	kubectl delete -f srcs/phpmyadmin.yaml >> logs.txt
# 	kubectl delete -f srcs/wordpress.yaml >> logs.txt
# 	kubectl delete -f srcs/grafana.yaml >> logs.txt
# 	kubectl delete -f srcs/influxdb.yaml >> logs.txt
# 	kubectl delete -f srcs/nginx.yaml >> logs.txt
# 	kubectl delete -f https://raw.githubusercontent.com/metallb/metallb/v0.9.3/manifests/namespace.yaml >> logs.txt

# 	printf "🗑  ✅ Clean complete!\n"
# }

# fclean() {
# 	printf "🗑  🐳 Cleaning all images...\n"

# 	docker rmi -f my_ftps >> logs.txt
# 	docker rmi -f my_mysql >> logs.txt
# 	docker rmi -f my_phpmyadmin >> logs.txt
# 	docker rmi -f my_wordpress >> logs.txt
# 	docker rmi -f my_grafana >> logs.txt
# 	docker rmi -f my_influxdb >> logs.txt
# 	docker rmi -f my_nginx >> logs.txt
# 	rm logs.txt
# 	minikube stop
# 	printf "🗑  🐳 ✅ fclean complete!\n"
# }

# # Clean if arg1 is clean or fclean
# if [[ $1 == 'clean' ]]
# then
# 	eval $(minikube docker-env)
# 	clean
# 	exit
# fi

# if [[ $1 == 'fclean' ]]
# then
# 	eval $(minikube docker-env)
# 	clean
# 	sleep 1
# 	fclean
# 	exit
# fi

# # Start the cluster if it's not running

# if [[ $(minikube status | grep -c "Running") == 0 ]]
# then
# 	minikube start --cpus=2 --memory 4000 --vm-driver=virtualbox --extra-config=apiserver.service-node-port-range=1-35000
# 	minikube addons enable metrics-server
# 	minikube addons enable ingress
# 	minikube addons enable dashboard
# fi


# # Set the docker images in Minikube

# MINIKUBE_IP=$(minikube ip)
# sleep 1;
# eval $(minikube docker-env)

# # Install metallb
# kubectl apply -f https://raw.githubusercontent.com/metallb/metallb/v0.9.3/manifests/namespace.yaml >> logs.txt
# kubectl apply -f https://raw.githubusercontent.com/metallb/metallb/v0.9.3/manifests/metallb.yaml >> logs.txt
# kubectl create secret generic -n metallb-system memberlist --from-literal=secretkey="$(openssl rand -base64 128)" >> logs.txt

# kubectl apply -f srcs/config.yaml >> logs.txt


# # Build Docker images

# printf "♻️   🐳  Building Docker images...\n"

# docker build -t my_ftps srcs/ftps >> logs.txt
# printf "🐳 🛠  FTPS done...\n"
# docker build -t my_mysql srcs/mysql >> logs.txt
# printf "🐳 🛠  MySQL done...\n"
# docker build -t my_phpmyadmin srcs/phpmyadmin >> logs.txt
# printf "🐳 🛠  PhpMyAdmin done...\n"
# docker build -t my_wordpress srcs/wordpress >> logs.txt
# printf "🐳 🛠  Wordpress done...\n"
# docker build -t my_influxdb srcs/influxdb >> logs.txt
# printf "🐳 🛠  InfluxDB done...\n"
# docker build -t my_grafana srcs/grafana >> logs.txt
# printf "🐳 🛠  Grafana done...\n"
# docker build -t my_nginx srcs/nginx >> logs.txt
# printf "🐳 🛠  Nginx done...\n"

# printf "✅  🐳  Images builded!\n"

# # Deploy services

# printf "♻️  Deploying services...\n"

# kubectl apply -f srcs/ftps.yaml >> logs.txt
# printf "🛠  FTPS done...\n"
# kubectl apply -f srcs/mysql.yaml >> logs.txt
# printf "🛠  MySQL done...\n"
# kubectl apply -f srcs/phpmyadmin.yaml >> logs.txt
# printf "🛠  PhpMyAdmin done...\n"
# kubectl apply -f srcs/wordpress.yaml >> logs.txt
# printf "🛠  Wordpress done...\n"
# kubectl apply -f srcs/influxdb.yaml >> logs.txt
# printf "🛠  InfluxDB done...\n"
# kubectl apply -f srcs/grafana.yaml >> logs.txt
# printf "🛠  Grafana done...\n"
# kubectl apply -f srcs/nginx.yaml >> logs.txt
# printf "🛠  Nginx done...\n"

# printf "✅ Deployed!\n"

# # Show ip acces

# echo "🌟 ft_services IP: ➡️  \"192.168.99.128\" ⬅️ "

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
echo "${BLUE}Deploy completed${END}"

# Setup metalLB secret.


# Enable addons.
minikube addons enable dashboard
minikube addons enable ingress
minikube addons enable metrics-server

# Open dashboard.
minikube dashboard