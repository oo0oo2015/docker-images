FROM centos:latest
MAINTAINER oo0oo "1148059382@qq.com"

RUN yum -y update \
	&& yum -y install kernel kernel-devel kernel-firmware kernel-headers \
	&& yum -y update kernel kernel-devel kernel-firmware kernel-headers \
	&& yum -y install yum-utils \
	&& yum-builddep -y python \
	&& yum -y install wget gcc make bzip2 \
	&& cd ~ \
	&& wget https://www.python.org/ftp/python/3.7.1/Python-3.7.1.tgz \
	&& tar xf Python-3.7.1.tgz \
	&& cd Python-3.7.1 \
	&& ./configure \
	&& make \
	&& make install \
	&& echo "alias python='/usr/local/bin/python3.7'" >> /etc/profile.d/python.sh \
	&& echo "alias pip='/usr/local/bin/pip3.7'" >> /etc/profile.d/python.sh \
	&& source /etc/profile.d/python.sh \
	&& cd ~ \
	&& rm -rf Python-3.7.1.tgz
	
RUN cd ~ \
	&& wget https://dev.mysql.com/get/mysql80-community-release-el7-1.noarch.rpm \
	&& yum -y install mysql80-community-release-el7-1.noarch.rpm \
	&& yum -y install mysql-server \
	&& rm -rf mysql80-community-release-el7-1.noarch.rpm
	
RUN cd ~ \
	&& wget http://download.redis.io/releases/redis-5.0.0.tar.gz \
	&& tar xzf redis-5.0.0.tar.gz \
	&& cd redis-5.0.0 \
	&& make \
	&& make install \
	&& cd ~ \
	&& rm -rf redis-5.0.0.tar.gz
	
RUN yum -y install epel-release \
	&& yum -y install python-pip \
	&& yum clean all \
	&& pip install --upgrade pip \
	&& pip install flask jinja2

RUN pip install flask-mysql pymysql sqlalchemy redis setuptools