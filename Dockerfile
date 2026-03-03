FROM ubuntu:trusty AS builder
WORKDIR /cow
RUN apt-get update && apt-get install -qy open-cobol apache2 libcob1
COPY ./app /cow
RUN ./downhill.sh
EXPOSE 80
CMD [ "-D", "FOREGROUND", "-f", "/cow/apache.conf"]
ENTRYPOINT [ "/usr/sbin/apachectl" ]
