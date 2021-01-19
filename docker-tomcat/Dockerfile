# 指定基于的基础镜像
FROM centos:latest

# 维护者信息
MAINTAINER lidangqi "llf860105@gmail.com"
      
# 镜像的指令操作

# 安装EPEL仓库
RUN yum install epel-release -y

# 添加中文语言包
RUN yum install langpacks-zh_CN -y
RUN export LANG=zh_CN.UTF-8
RUN echo "export LANG=zh_CN.UTF-8" >> /etc/locale.conf
ENV LANG zh_CN.UTF-8
ENV LC_ALL zh_CN.UTF-8

# 开启SSH
RUN yum install openssh-server -y 

#修改root用户密码
#用以下命令修改密码时，密码中最好不要包含特殊字符，如"!"，否则可能会失败；
RUN yum install passwd -y
RUN /bin/echo "root6666" | passwd --stdin root

#生成密钥
RUN ssh-keygen -t rsa -f /etc/ssh/ssh_host_rsa_key \
    && ssh-keygen -t rsa -f /etc/ssh/ssh_host_ecdsa_key \
    && ssh-keygen -t rsa -f /etc/ssh/ssh_host_ed25519_key

#修改配置信息
RUN /bin/sed -i 's/.*session.*required.*pam_loginuid.so.*/session optional pam_loginuid.so/g' /etc/pam.d/sshd \
    && /bin/sed -i 's/UsePAM yes/UsePAM no/g' /etc/ssh/sshd_config \
    && /bin/sed -i "s/#UsePrivilegeSeparation.*/UsePrivilegeSeparation no/g" /etc/ssh/sshd_config


EXPOSE 22

# 安装nginx
#ADD  获取url中的文件,放在当前目录下
ADD http://nginx.org/download/nginx-1.18.0.tar.gz .
 
#RUN 执行以下命令 
RUN yum install -y pcre-devel wget net-tools gcc zlib zlib-devel make openssl-devel
RUN useradd -M -s /sbin/nologin nginx
RUN tar -zxvf nginx-1.18.0.tar.gz
RUN mkdir -p /usr/local/nginx
RUN cd nginx-1.18.0 && ./configure --prefix=/usr/local/nginx --user=nginx --group=nginx --with-http_stub_status_module && make && make install
RUN ln -s /usr/local/nginx/sbin/* /usr/local/sbin/
 
#EXPOSE 映射端口
EXPOSE 80
RUN yum install curl vim -y

# Install JDK 8  
RUN cd /tmp &&  curl -L 'https://repo.huaweicloud.com/java/jdk/8u202-b08/jdk-8u202-linux-x64.tar.gz' | tar -xz
RUN mv /tmp/jdk1.8.0_202/ /usr/local/java-8-oracle/
  
# Set Oracle JDK 8 as default Java  
RUN update-alternatives --install /usr/bin/java java /usr/local/java-8-oracle/bin/java 300     
RUN update-alternatives --install /usr/bin/javac javac /usr/local/java-8-oracle/bin/javac 300     
  
ENV JAVA_HOME /usr/local/java-8-oracle/ 
ENV CLASSPATH $JAVA_HOME/lib/dt.jar:$JAVA_HOME/lib/tools.jar
  
# Install tomcat8  
RUN cd /tmp && curl -L 'http://archive.apache.org/dist/tomcat/tomcat-8/v8.5.59/bin/apache-tomcat-8.5.59.tar.gz' | tar -xz
RUN mv /tmp/apache-tomcat-8.5.59/ /usr/local/tomcat8/
ENV CATALINA_HOME /usr/local/tomcat8
ENV PATH $PATH:$JAVA_HOME/bin:$CATALINA_HOME/lib:$CATALINA_HOME/bin

# Expose ports
EXPOSE 8080  

# Install maven
RUN cd /tmp && curl -L 'https://apache.claz.org/maven/maven-3/3.6.3/binaries/apache-maven-3.6.3-bin.tar.gz' | tar -xz
RUN mv /tmp/apache-maven-3.6.3/ /usr/local/apache-maven-3.6.3/

ENV MAVEN_HOME /usr/local/apache-maven-3.6.3
ENV PATH $PATH:$JAVA_HOME/bin:$CATALINA_HOME/lib:$CATALINA_HOME/bin:$MAVEN_HOME/bin
RUN sed -i '499,509 s/"&"/ /' /usr/local/tomcat8/bin/catalina.sh

#CMD 运行以下命令
# Start tomcat
CMD ["/usr/local/tomcat8/bin/catalina.sh","run"]
CMD ["nginx","run"]