FROM ubuntu

MAINTAINER Leon <leon.zeng@qq.com>

WORKDIR /root

#install openssh-server and wget java8 etc
ENV JAVA_HOME=/usr/lib/jvm/default-java
ENV PATH=$PATH:$JAVA_HOME/bin

RUN apt-get update && apt-get install -y openssh-server wget net-tools iputils-ping curl vim &&\
	wget http://192.168.1.2/down/jdk-8u144-linux-x64.tar.gz && \
	tar -xzf jdk-8u144-linux-x64.tar.gz && \
	mkdir /usr/lib/jvm && mv jdk1.8.0_144/ /usr/lib/jvm/ && \
	ln -s /usr/lib/jvm/jdk1.8.0_144 /usr/lib/jvm/default-java && \
	update-alternatives --install /usr/bin/java java $JAVA_HOME/bin/java 300 && \
	ssh-keygen -t rsa -f ~/.ssh/id_rsa -P '' && \
    cat ~/.ssh/id_rsa.pub >> ~/.ssh/authorized_keys && \
	rm *.gz

COPY config/ssh_config /root/.ssh/config
COPY config/.vimrc /root/

CMD [ "sh", "-c", "service ssh start; bash"]

EXPOSE 22

