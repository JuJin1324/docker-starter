FROM ubuntu:16.04
MAINTAINER jujin <jujin@daum.net>
RUN apt-get update \
&& apt-get install -y openssh-server \
    vim \
    net-tools \
    language-pack-ko
RUN locale-gen ko_KR.UTF-8

RUN mkdir /var/run/sshd
## set password
RUN echo 'root:root' |chpasswd

#replace sshd_config
RUN sed -ri 's/^#?PermitRootLogin\s+.*/PermitRootLogin yes/' /etc/ssh/sshd_config
RUN sed -ri 's/UsePAM yes/#UsePAM yes/g' /etc/ssh/sshd_config

#make .ssh
RUN mkdir /root/.ssh
RUN apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/

EXPOSE 22

CMD ["/usr/sbin/sshd", "-D"]