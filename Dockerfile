FROM node:12.13.0-alpine
RUN mkdir -p /opt/app
WORKDIR /opt/app
COPY app/ .
RUN npm install
EXPOSE 3000
CMD [ "npm", "start" ]
