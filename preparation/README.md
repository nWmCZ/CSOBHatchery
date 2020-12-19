# CSOB Hatchery
## install java manually
```
yum install -y java-1.8.0-openjdk.x86_64
```

## install java with ansible
```
ansible-playbook -i inventory_azure.ini install_dependencies.yml
```

## verify java installation
```
java -version
```

## enable firewall ports
```
firewall-cmd --zone=public --add-port=80/tcp --permanent
firewall-cmd --zone=public --add-port=8080/tcp --permanent
firewall-cmd --zone=public --add-port=443/tcp --permanent
firewall-cmd --zone=public --add-port=8443/tcp --permanent
firewall-cmd --zone=public --add-port=8161/tcp --permanent
firewall-cmd --zone=public --add-port=61616/tcp --permanent
firewall-cmd --zone=public --add-port=61616/tcp --permanent
firewall-cmd --zone=public --add-port=61616/tcp --permanent
firewall-cmd --reload
```
