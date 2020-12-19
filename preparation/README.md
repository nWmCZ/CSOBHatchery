# CSOB Hatchery
## preparation
### terraform
```shell
cd terraform/PracticeServers_Azure
terraform init
terraform plan
terraform apply
```

### install java manually
```
yum install -y java-1.8.0-openjdk.x86_64
```

### add users with ansible
```shell
uncomment task in create_user.yml
ansible-playbook -i inventory_azure.ini create_user -e "user_name=lector sudo_rights=true"
```

### install java with ansible
```
ansible-playbook -i inventory_azure.ini install_dependencies.yml
```

### verify java installation
```
java -version
```

### enable firewall ports
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

### add mysql databases and users
```roomsql
CREATE DATABASE user1;
CREATE USER 'user1'@'%' IDENTIFIED BY 'password';
GRANT ALL
  ON user1.*
  TO 'user1'@'%'
  WITH GRANT OPTION;
FLUSH PRIVILEGES;
```