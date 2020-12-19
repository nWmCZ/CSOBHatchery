# Exercise 1 - Tomcat basics

## copy ActiveMQ package
```
scp <-your_name->@<-shared_storage_ip->/share/apache-tomcat-9.0.41.tar.gz /opt
```

## extract the archive
```shell
tar xf apache-tomcat-9.0.41.tar.gz
```

## go to bin folder and start the ActiveMQ
```shell
cd apache-tomcat-9.0.41/bin
./catalina start
```
## edit users
```shell
vi conf/tomcat-users.xml
```

## disable localhost access for manager
```shell
vi webapps/manager/META-INF/context.xml
replace "127\.\d+\.\d+\.\d+|::1|0:0:0:0:0:0:0:1" with ".*"
vi webapps/host-manager/META-INF/context.xml
replace "127\.\d+\.\d+\.\d+|::1|0:0:0:0:0:0:0:1" with ".*"
```
