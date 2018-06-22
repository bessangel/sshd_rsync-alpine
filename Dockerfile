FROM alpine:latest

MAINTAINER Mitalex s.r.o. <info@mitalex.org>

RUN apk update \
 && apk upgrade \
  && apk add --no-cache rsync openssh-server \
  && rm -rf /var/cache/apk/* \
  && mkdir /var/run/sshd \
  && echo 'root:root' |chpasswd \
  && sed -ri 's/^#?PermitRootLogin\s+.*/PermitRootLogin yes/' /etc/ssh/sshd_config \
  && sed -ri 's/UsePAM yes/#UsePAM yes/g' /etc/ssh/sshd_config \
  && mkdir /root/.ssh \
  &&  /usr/bin/ssh-keygen -A

  EXPOSE 22

  CMD    ["/usr/sbin/sshd", "-D"]
