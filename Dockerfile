# CentOS based
FROM centos:latest
MAINTAINER Miroslav Svoboda <miroslav.svoboda@karumien.com>

# Install utils
RUN yum update -y
RUN yum install -y wget

# Install JDK 8 
RUN wget --no-check-certificate --no-cookies --header "Cookie: oraclelicense=accept-securebackup-cookie" http://download.oracle.com/otn-pub/java/jdk/8u45-b14/jdk-8u45-linux-x64.rpm
RUN rpm -ivh jdk-8*-linux-x64.rpm && rm jdk-8*-linux-x64.rpm

# Set the environment variables 
ENV JAVA_HOME /usr/java/latest
ENV PATH $PATH:$JAVA_HOME/bin

# Force Docker to use UTF-8 encodings
ENV LANG C.UTF-8

# Maven install
ENV MAVEN_VERSION=3.5.2
ENV MAVEN_HOME=/opt/mvn

# change to tmp folder
WORKDIR /tmp

# Download and extract maven to opt folder
RUN wget --no-check-certificate --no-cookies https://repo1.maven.org/maven2/org/apache/maven/apache-maven/${MAVEN_VERSION}/apache-maven-${MAVEN_VERSION}-bin.tar.gz \
    && wget --no-check-certificate --no-cookies https://repo1.maven.org/maven2/org/apache/maven/apache-maven/${MAVEN_VERSION}/apache-maven-${MAVEN_VERSION}-bin.tar.gz.md5 \
    && echo "$(cat apache-maven-${MAVEN_VERSION}-bin.tar.gz.md5) apache-maven-${MAVEN_VERSION}-bin.tar.gz" | md5sum -c \
    && tar -zvxf apache-maven-${MAVEN_VERSION}-bin.tar.gz -C /opt/ \
    && ln -s /opt/apache-maven-${MAVEN_VERSION} /opt/mvn \
    && rm -f apache-maven-${MAVEN_VERSION}-bin.tar.gz \
    && rm -f apache-maven-${MAVEN_VERSION}-bin.tar.gz.md5

# add executables to path
RUN update-alternatives --install "/usr/bin/mvn" "mvn" "/opt/mvn/bin/mvn" 1 && \
    update-alternatives --set "mvn" "/opt/mvn/bin/mvn" 
    
ENV PATH $PATH:$MAVEN_HOME/bin
