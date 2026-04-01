FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y \
    openssh-server \
    mysql-client \
    && rm -rf /var/lib/apt/lists/*

RUN useradd -m -s /bin/bash bastionuser \
    && mkdir -p /home/bastionuser/.ssh \
    && chmod 700 /home/bastionuser/.ssh

COPY bastion-config/authorized_keys /home/bastionuser/.ssh/authorized_keys

RUN chmod 600 /home/bastionuser/.ssh/authorized_keys \
    && chown -R bastionuser:bastionuser /home/bastionuser/.ssh

RUN mkdir /var/run/sshd \
    && sed -i 's/#PasswordAuthentication yes/PasswordAuthentication no/' /etc/ssh/sshd_config \
    && sed -i 's/#PubkeyAuthentication yes/PubkeyAuthentication yes/' /etc/ssh/sshd_config \
    && echo "AllowUsers bastionuser" >> /etc/ssh/sshd_config

EXPOSE 22
CMD ["/usr/sbin/sshd", "-D"]