# node container; see https://hub.docker.com/r/_/node/
FROM node:7.10.0

# update node (if needed...)
#sudo npm cache clean -f
#sudo npm install -g n
#sudo n stable

# change working directory
RUN mkdir /usr/src/app
WORKDIR /usr/src/app

# clone Node.js REST repo code into the docker container 
RUN git clone https://github.com/OpenChirp/openchirp_rest /usr/src/app

# install dependencies according to package.json
RUN npm install

ADD ./config/* /usr/src/app/config/

# application's default port
#EXPOSE 10010