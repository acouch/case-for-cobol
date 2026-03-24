# Stage 1: compile USWDS assets
FROM node:20 AS uswds-builder
WORKDIR /build
COPY package.json ./
RUN npm install
COPY gulpfile.js ./
RUN npx gulp init && npx gulp compile

# Stage 2: compile COBOL
FROM ubuntu:trusty AS cobol-builder
WORKDIR /cow
RUN apt-get update && apt-get install -qy open-cobol apache2 libcob1
COPY ./app /cow
COPY --from=uswds-builder /build/app/assets /cow/assets
RUN ./downhill.sh

# Stage 3: runtime
FROM ubuntu:trusty
RUN apt-get update && apt-get install -qy apache2 libcob1
COPY --from=cobol-builder /cow /cow
EXPOSE 80
CMD [ "-D", "FOREGROUND", "-f", "/cow/apache.conf"]
ENTRYPOINT [ "/usr/sbin/apachectl" ]
