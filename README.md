# Library
数据结构--智慧图书馆

## 项目结构
-数据库
  数据库使用mysql
  jdbc连接时设定的mysql用户名为root，密码123；
  新建database：Library，然后执行Library.sql

-jdk、服务器
  服务器使用tomacat 7.8.01
  jdk1.6.0_65
  理论上jdk版本高于1.6都可以正常运行

-依赖
  将lib.zip内的jar包解压到${tomcat安装目录}/lib下
  
-运行
  将/out/artifacts/Library_war_exploded/Library.war复制到${tomcat}/webapps/ROOT下，启动tomcat，访问127.0.0.1/Library/html/index.jsp
