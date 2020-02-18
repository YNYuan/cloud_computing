FROM ubuntu
MAINTAINER 001

USER root

RUN apt-get update 

RUN apt-get install -y sudo wget openssh-server openssh-client

RUN apt-get install -y openjdk-8-jdk

RUN mkdir /home/user1
WORKDIR /home/user1
RUN wget http://ftp.wayne.edu/apache/hadoop/common/hadoop-3.2.1/hadoop-3.2.1.tar.gz
RUN tar -xzf hadoop-3.2.1.tar.gz

RUN echo "export JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64/" >> hadoop-3.2.1/etc/hadoop/hadoop-env.sh

RUN mkdir input
RUN cp hadoop-3.2.1/etc/hadoop/*.xml input
RUN hadoop-3.2.1/bin/hadoop jar hadoop-3.2.1/share/hadoop/mapreduce/hadoop-mapreduce-examples-3.2.1.jar grep input output 'dfs[a-z.]+'
RUN cat hadoop-3.2.1/output/*
