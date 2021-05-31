# Exercise 3 - ActiveMQ HA
See HA picture for draw.io

## copy mysql connector package
```
scp <-your_name->@<-shared_storage_ip->/share/mysql-connector-java-8.0.22.tar.gz /opt
```

## extract the archive
```shell
tar xf apache-activemq-5.16.0-bin.tar.gz
```

## copy mysql connector to lib folder
```shell
cp ~/mysql-connector-java-8.0.22/mysql-connector-java-8.0.22.jar ~/apache-activemq-5.16.0/lib/
```

## go to bin folder and start the ActiveMQ
```shell
cd apache-activemq-5.16.0/bin
./activemq console
./activemq start
```

## edit activemq.xml and add mysql datastore
```shell
vi activemq.xml
change localhost in brokerName field to unique name
add bean (ref1) and change persistence adapter (ref2)
```

## ref1
```xml
<bean id="mysql-ds" class="org.apache.commons.dbcp2.BasicDataSource" destroy-method="close">
  <property name="driverClassName" value="com.mysql.cj.jdbc.Driver"/>
  <property name="url" value="jdbc:mysql://csobmysql.mysql.database.azure.com/YOURNAME?serverTimezone=UTC&amp;relaxAutoCommit=true"/>
  <property name="username" value="YOURNAME@csobmysql"/>
  <property name="password" value="YOURPASSWORDFROMCAT"/>
  <property name="poolPreparedStatements" value="true"/>
</bean>
```

## ref2
```xml
<persistenceAdapter> 
  <jdbcPersistenceAdapter dataSource="#mysql-ds"/> 
</persistenceAdapter>
```

## verify
go to http://ip:8161/ login is admin/admin
