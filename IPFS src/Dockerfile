FROM mhart/alpine-node:8
MAINTAINER Oraclize "info@oraclize.it"


WORKDIR /app
COPY package.json /app
RUN npm install
COPY . /app
CMD node index.js $ARG0 $ARG1 $ARG2 $ARG3 && exit 0
