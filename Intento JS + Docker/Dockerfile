FROM mhart/alpine-node:8
MAINTAINER Oraclize "info@oraclize.it"


WORKDIR /app
COPY package.json /app
RUN npm install
COPY . /app
CMD node index.js && exit 0
