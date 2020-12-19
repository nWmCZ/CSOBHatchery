# Exercise 2 - ActiveMQ basics

## copy ActiveMQ package
```
scp <-your_name->@<-shared_storage_ip->/share/apache-activemq-5.16.0-bin.tar.gz /opt
```

## extract the archive
```shell
tar xf apache-activemq-5.16.0-bin.tar.gz
```

## go to bin folder and start the ActiveMQ
```shell
cd apache-activemq-5.16.0/bin
./activemq console
./activemq start
```

## change jetty configuration
```shell
cd apache-activemq-5.16.0/conf
vi jetty.xml
replace 127.0.0.1 to 0.0.0.0
```

## verify
go to http://ip:8161/ login is admin/admin

## extra tasks
- change admin password
