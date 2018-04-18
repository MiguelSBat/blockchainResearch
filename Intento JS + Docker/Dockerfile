FROM mhart/alpine-node:8
MAINTAINER Oraclize "info@oraclize.it"

COPY index.js /tmp/
WORKDIR /tmp/
RUN npm install request
CMD node index.js $ARG0
