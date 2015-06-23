FROM ubuntu:14.04                                                                                                                                  
ENV DEBIAN_FRONTEND noninteractive                                                                                                

ADD mariadb.list /etc/apt/sources.list.d/
RUN chown root: /etc/apt/sources.list.d/mariadb.list
RUN apt-get update &&  \
    apt-key adv --recv-keys --keyserver hkp://keyserver.ubuntu.com:80 0xcbcb082a1bb943db && \
    apt-get update && \
    apt-get install -y mariadb-galera-server galera

COPY my.cnf /etc/mysql/my.cnf                                                                                                     
COPY mysqld.sh /mysqld.sh

RUN chmod 555 /mysqld.sh

# Define mountable directories.                                                                                                   
VOLUME ["/var/lib/mysql"]                                                                                                         

# Define default command.                                                                                                         
ENTRYPOINT ["/mysqld.sh"]                                                                                                             
