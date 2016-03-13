FROM ubuntu

#ssh {

RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get -y install openssh-server pwgen
RUN apt-get clean
RUN mkdir -p /var/run/sshd && sed -i "s/UsePrivilegeSeparation.*/UsePrivilegeSeparation no/g" /etc/ssh/sshd_config && sed -i "s/UsePAM.*/UsePAM no/g" /etc/ssh/sshd_config && sed -i "s/PermitRootLogin.*/PermitRootLogin yes/g" /etc/ssh/sshd_config

ADD set_root_pw.sh /set_root_pw.sh

ENV AUTHORIZED_KEYS **None**

#ssh }

RUN apt-get update
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y vim nano curl wget zip \
	nginx \
	php5-cli php5-cgi php5-fpm php5-mcrypt php5-mysql
RUN apt-get clean

ADD nginx_default /etc/nginx/sites-available/default
RUN mkdir /var/www
RUN chmod 777 /var/www
ADD run.sh /run.sh
RUN chmod +x /*.sh



ADD LFS /usr/sbin/LFS
RUN chmod +x /usr/sbin/LFS

ADD LFS.sh /etc/init.d/LFS
RUN chmod +x /etc/init.d/LFS
RUN update-rc.d LFS defaults



EXPOSE 9002 9003 9005 9006 80 443 22

ENTRYPOINT ["/run.sh"]
