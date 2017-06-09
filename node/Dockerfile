# node container; see https://hub.docker.com/r/_/node/
FROM node:7.10.0

# update node (uncomment, if needed...)
#sudo npm cache clean -f
#sudo npm install -g n
#sudo n stable

# copy code into the docker container 
#RUN git clone https://github.com/OpenChirp/openchirp_rest /usr/src/app
COPY ./code/ /usr/src/app/

# change working directory
WORKDIR /usr/src/app

# install dependencies according to package.json
RUN npm install

# copy config files to temp folder, so they are copied at container execution time
ADD ./config/* /run/config/