---
layout: post
title: "Backup de todas las bases de datos en MySQL"
date: 2013-01-18T16:56:00.001Z
last_modified_at: 2013-01-18T17:00:24.908Z
author: "Diego Silva Límaco"
permalink: /2013/01/backup-de-todas-las-bases-de-datos-en.html
canonical_url: https://www.apuntesdejava.com/2013/01/backup-de-todas-las-bases-de-datos-en.html
tags:
  - "opnj"
  - "mysql"
  - "windows"
  - "tips"
  - "off topic"
---

![]({{ '/assets/blogger/backup1.png' | relative_url }})

Comparto otro post no java (OPNJ) referente a MySQL.

La idea es simple: quiero hacer backup de todas las bases de datos de MySQL, pero con las siguientes condiciones:

- Un archivo sql por cada base de datos

- Que en el nombre del archivo indique la fecha en que se hizo el backup

- Y que se ejecute en Windows.

Hacemos un archivo .bat con el siguiente contenido:

```java
set USER=root
set PASS=password
set DB_LIST=databases.txt

REM obtenemos todas las bases de datos
echo  show databases where not `Database` like '%%schema' | mysql -u %USER% -p%PASS% --column-names=false > %DB_LIST%

REM recorre el contenido del archivo y ejecuta el comando mysqldump
FOR /F %%G  IN (%DB_LIST%) DO  mysqldump -u %USER% -p%PASS% -B %%G -R --hex-blob=true > %%G-%DATE:~6,4%-%DATE:~3,2%-%DATE:~0,2%.sql
```

y ahora, para que se ejecute cada cierto tiempo, usar el "Programador de Tareas de Windows".

 saludos
