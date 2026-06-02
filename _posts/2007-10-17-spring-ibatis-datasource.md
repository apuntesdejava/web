---
layout: post
title: "Spring + iBatis + DataSource"
date: 2007-10-17T16:43:00Z
last_modified_at: 2009-04-25T21:55:03.664Z
author: "Diego Silva"
permalink: /2007/10/spring-ibatis-datasource.html
canonical_url: https://www.apuntesdejava.com/2007/10/spring-ibatis-datasource.html
tags:
  - "spring"
  - "ibatis"
  - "dao"
  - "datasource"
---

Este es un extracto de un .xml para Spring Framework que crea un DataSource y lo pone al iBatis para implementar DAO.

```java
<code><?xml version="1.0" encoding="UTF-8"?><br /><beans xmlns="http://www.springframework.org/schema/beans"<br />     xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"<br />     xsi:schemaLocation="http://www.springframework.org/schema/beans http://www.springframework.org/schema/beans/spring-beans-2.0.xsd"><br /><!-- obtengo el .properties con las variables que tiene los datos de la conexion --><br />  <bean class="org.springframework.beans.factory.config.PropertyPlaceholderConfigurer"><br />      <property name="locations"><br />          <value>classpath:net/andesconsulting/resources/database.properties</value><br />      </property><br />  </bean><br /><!-- creo el datasource --><br />  <bean id="dataSource" class="org.apache.commons.dbcp.BasicDataSource" destroy-method="close"><br />      <property name="driverClassName" value="${jdbc.driverClassName}"/><br />      <property name="url" value="${jdbc.url}"/><br />      <property name="username" value="${jdbc.username}"/><br />      <property name="password" value="${jdbc.password}"/><br />      <property name="maxActive" value="10"/><br />      <property name="maxIdle" value="5"/><br />      <property name="maxWait" value="60000"/><br />      <property name="logAbandoned" value="true"/><br />      <property name="removeAbandoned" value="true"/><br />      <property name="removeAbandonedTimeout" value="50000"/><br />      <property name="initialSize" value="5"/><br />    <br />  </bean><br /><!-- creo la conexion para ibatis -->  <br />  <bean id="sqlMapClient" class="org.springframework.orm.ibatis.SqlMapClientFactoryBean"><br />      <property name="configLocation" value="classpath:net/andesconsulting/ibatis/sqlmap-config.xml"/><br />      <property name="dataSource" ref="dataSource"/><br />  </bean><br /><!-- creo la implementacion del dao -><br /> <bean id="logonDao" class="net.andesconsulting.dao.sqlmap.SqlMapLogonDao"><br />      <property name="sqlMapClient" ref="sqlMapClient"/><br />  </bean><br /><!--- sigue ---><br /></code>
```
