FROM ubuntu:14.04

RUN apt-get update
RUN apt-get install -y software-properties-common python-software-properties
RUN add-apt-repository -y ppa:openjdk-r/ppa
RUN apt-get update
RUN apt-get install -y openjdk-8-jdk
RUN update-alternatives --config java
RUN update-alternatives --config javac


# Setup
RUN apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv E56151BF

# Add the repository
RUN echo "deb http://repos.mesosphere.com/ubuntu trusty main" | \
    tee /etc/apt/sources.list.d/mesosphere.list
RUN apt-get -y update
RUN apt-get -y install mesos

RUN apt-get -y install wget

RUN wget -q -O - https://pkg.jenkins.io/debian/jenkins-ci.org.key | sudo apt-key add -
RUN sh -c 'echo deb http://pkg.jenkins.io/debian-stable binary/ > /etc/apt/sources.list.d/jenkins.list'
RUN apt-get update
RUN apt-get install -y jenkins

RUN apt-get clean && \
	rm -rf /var/lib/apt/lists/* && \
	rm -rf /var/cache/oracle-jdk8-installer

# Default system timezone (Singapore)
ENV TIMEZONE=GMT+08
# Used to configure OS language support
ENV LANGUAGE=en_US.UTF-8

ENV JAVA_HOME /usr/lib/jvm/java-8-openjdk-amd64/
RUN export JAVA_HOME
