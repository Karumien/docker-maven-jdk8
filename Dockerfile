# CentOS based
FROM centos:latest
MAINTAINER Miroslav Svoboda <miroslav.svoboda@karumien.com>

# Set environment variables for versions
ENV JDK_VERSION=8
ENV JDK_UPDATE=152
ENV JDK_BUILD=b16
ENV JDK_DISTRO_ARCH=linux-x64

ENV JCE_FOLDER=UnlimitedJCEPolicyJDK$JDK_VERSION
ENV JDK_FOLDER=jdk1.$JDK_VERSION.0_$JDK_UPDATE
ENV JDK_VERSION_UPDATE=$JDK_VERSION'u'$JDK_UPDATE
ENV JDK_VERSION_UPDATE_BUILD=$JDK_VERSION_UPDATE'-'$JDK_BUILD
ENV JDK_VERSION_UPDATE_DISTRO_ARCH=$JDK_VERSION_UPDATE'-'$JDK_DISTRO_ARCH

ENV JAVA_HOME=/opt/java
ENV JRE_SECURITY_FOLDER=$JAVA_HOME/jre/lib/security
ENV SSL_TRUSTED_CERTS_FOLDER=/opt/ssl/trusted
ENV PATH $PATH:$JAVA_HOME/bin

# Install utils
RUN yum update -y
RUN yum install -y wget

# Change to tmp folder
WORKDIR /tmp

# Download and extract jdk to opt folder
RUN wget --no-check-certificate https://github.com/frekele/oracle-java/releases/download/${JDK_VERSION_UPDATE_BUILD}/jdk-${JDK_VERSION_UPDATE_DISTRO_ARCH}.tar.gz \
    && wget --no-check-certificate https://github.com/frekele/oracle-java/releases/download/${JDK_VERSION_UPDATE_BUILD}/jdk-${JDK_VERSION_UPDATE_DISTRO_ARCH}.tar.gz.md5 \
    && echo "$(cat jdk-${JDK_VERSION_UPDATE_DISTRO_ARCH}.tar.gz.md5) jdk-${JDK_VERSION_UPDATE_DISTRO_ARCH}.tar.gz" | md5sum -c \
    && tar -zvxf jdk-${JDK_VERSION_UPDATE_DISTRO_ARCH}.tar.gz -C /opt \
    && ln -s /opt/${JDK_FOLDER} /opt/java \
    && rm -f jdk-${JDK_VERSION_UPDATE_DISTRO_ARCH}.tar.gz \
    && rm -f jdk-${JDK_VERSION_UPDATE_DISTRO_ARCH}.tar.gz.md5
    
# Add executables to path
RUN update-alternatives --install "/usr/bin/java" "java" "/opt/java/bin/java" 1 && \
    update-alternatives --set "java" "/opt/java/bin/java" && \
    update-alternatives --install "/usr/bin/javac" "javac" "/opt/java/bin/javac" 1 && \
    update-alternatives --set "javac" "/opt/java/bin/javac" && \
    update-alternatives --install "/usr/bin/keytool" "keytool" "/opt/java/bin/keytool" 1 && \
    update-alternatives --set "keytool" "/opt/java/bin/keytool"

# Create trusted ssl certs folder
RUN mkdir -p $SSL_TRUSTED_CERTS_FOLDER

# Mark as volume
VOLUME $SSL_TRUSTED_CERTS_FOLDER

# Force Docker to use UTF-8 encodings
ENV LANG C.UTF-8

# Maven install
ENV MAVEN_VERSION=3.5.2
ENV MAVEN_HOME=/opt/mvn
ENV PATH $PATH:$MAVEN_HOME/bin

# Change to tmp folder
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
