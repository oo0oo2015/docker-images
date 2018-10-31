FROM centos:latest
MAINTAINER oo0oo "1148059382@qq.com"

# 装Python以及其他常用工具
RUN yum -y update \
	&& yum -y install kernel kernel-devel kernel-firmware kernel-headers \
	&& yum -y update kernel kernel-devel kernel-firmware kernel-headers \
	&& yum -y install yum-utils \
	&& yum-builddep -y python \
	&& yum -y install wget gcc make bzip2 openssl-devel zlib-devel\
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
	
# 装MySQL 8.0
RUN cd ~ \
	&& wget https://dev.mysql.com/get/mysql80-community-release-el7-1.noarch.rpm \
	&& yum -y install mysql80-community-release-el7-1.noarch.rpm \
	&& yum -y install mysql-server \
	&& rm -rf mysql80-community-release-el7-1.noarch.rpm
	
# 装Redis 5.0.0
RUN cd ~ \
	&& wget http://download.redis.io/releases/redis-5.0.0.tar.gz \
	&& tar xzf redis-5.0.0.tar.gz \
	&& cd redis-5.0.0 \
	&& make \
	&& make install \
	&& cd ~ \
	&& rm -rf redis-5.0.0.tar.gz
	
# 装常用Python package
RUN cd ~ \
	&& python -V \
	&& pip --version \
	&& wget --no-check-certificate https://files.pythonhosted.org/packages/45/ae/8a0ad77defb7cc903f09e551d88b443304a9bd6e6f124e75c0fbbf6de8f7/pip-18.1.tar.gz \
	&& tar -zxvf pip-18.1.tar.gz \
	&& cd pip-18.1 \
	&& python setup.py build \
	&& python setup.py install \
	&& pip --version \
	&& pip install --upgrade pip \
	&& pip --version \
	&& pip install flask jinja2 flask-mysql pymysql sqlalchemy redis setuptools