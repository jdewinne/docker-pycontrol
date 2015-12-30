FROM ubuntu:latest
MAINTAINER Joris De Winne <jdewinne@xebialabs.com>
RUN apt-get update
RUN apt-get install -y python-pip openssh-server supervisor
RUN pip install suds
RUN pip install pycontrol

RUN echo "root:pycontrol" | chpasswd

ADD "resources/sshd_config" "/etc/ssh/sshd_config"
ADD "resources/supervisord.conf" "/etc/supervisor/conf.d/supervisord.conf"
RUN chmod 644 /etc/ssh/sshd_config
RUN mkdir -p /var/log/supervisor /var/run/sshd

EXPOSE 22
CMD ["/usr/bin/supervisord"]
