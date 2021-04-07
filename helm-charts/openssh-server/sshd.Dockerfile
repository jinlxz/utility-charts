FROM debian:buster
RUN apt update && \
    apt install openssh-server -y
ARG sshd_config=/etc/ssh/sshd_config
COPY ./resources/authorized_keys/*.pub /root/.ssh/
RUN echo "PermitRootLogin prohibit-password" >> $sshd_config && \
    echo "PubkeyAuthentication yes" >> $sshd_config && \
    cat /root/.ssh/*.pub >> /root/.ssh/authorized_keys && \
    mkdir /run/sshd/

ENTRYPOINT ["/bin/bash"]