FROM dockerfile/nodejs

RUN mkdir -p /usr/src/mtp

WORKDIR /usr/src/mtp

COPY dist/package.json /usr/src/mtp/package.json

RUN npm install

VOLUME ["/usr/src/mtp/server", "/usr/src/mtp/public"]

CMD ["npm", "start"]
