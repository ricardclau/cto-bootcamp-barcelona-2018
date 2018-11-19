FROM php:7.1-apache

# Install filebeat
RUN curl https://artifacts.elastic.co/downloads/beats/filebeat/filebeat-5.6.7-linux-x86_64.tar.gz --output /tmp/filebeat.tar.gz && \
    cd /tmp && \
    tar xzvf filebeat.tar.gz && \
    cd filebeat-* && \
    cp filebeat /bin && \
    cd /tmp && \
    rm -rf filebeat && \
    mkdir /var/log/filebeat

# Add Filebeat config
ADD config/filebeat.yml /etc/filebeat/filebeat.yml