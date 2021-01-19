# 指定基于的基础镜像
FROM centos:7

# 维护者信息
MAINTAINER lidangqi "llf860105@gmail.com"

# 镜像的指令操作

# 添加JDK、TOMCAT、maven
ADD jdk-8u45-linux-x64.tar.gz /usr/local/
ADD apache-tomcat-8.5.59.tar.gz /usr/local/
ADD apache-maven-3.5.0-bin.tar.gz /usr/local/

# 添加环境变量
ENV JAVA_HOME /usr/local/jdk1.8.0_45
ENV CLASSPATH $JAVA_HOME/lib/dt.jar:$JAVA_HOME/lib/tools.jar
ENV CATALINA_HOME /usr/local/apache-tomcat-8.5.59
ENV MAVEN_HOME /usr/local/apache-maven-3.5.0
ENV PATH $PATH:$JAVA_HOME/bin:$CATALINA_HOME/lib:$CATALINA_HOME/bin:$MAVEN_HOME/bin

# 暴露tomcat端口
EXPOSE 8080

# 启动web app
CMD /usr/local/apache-tomcat-8.5.59/bin/catalina.sh run

