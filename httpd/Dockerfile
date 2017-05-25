# apache container; see https://hub.docker.com/_/httpd/
FROM httpd:2.4

# replace shell with bash so we can source files
RUN rm /bin/sh && ln -s /bin/bash /bin/sh

# install git
RUN apt-get update && apt-get install git -y

# update the repository sources list
# and install dependencies
RUN apt-get update \
    && apt-get install -y curl \
    && apt-get -y autoclean

# nvm environment variables
ENV NVM_DIR /usr/local/nvm
ENV NODE_VERSION 6.10.3

# install nvm
# https://github.com/creationix/nvm#install-script
RUN curl --silent -o- https://raw.githubusercontent.com/creationix/nvm/master/install.sh | bash

# install node and npm
RUN source $NVM_DIR/nvm.sh \
    && nvm install $NODE_VERSION \
    && nvm alias default $NODE_VERSION \
    && nvm use default

# add node and npm to path so the commands are available
ENV NODE_PATH $NVM_DIR/v$NODE_VERSION/lib/node_modules
ENV PATH $NVM_DIR/versions/node/v$NODE_VERSION/bin:$PATH

#install angular cli
RUN npm install -g @angular/cli

# clone website repo code into the docker container 
RUN rm -fr /tmp/openchirp-website
RUN git clone https://github.com/OpenChirp/website.git /tmp/openchirp-website
WORKDIR /tmp/openchirp-website/
RUN npm install
RUN ng build --prod
RUN cp -R /tmp/openchirp-website/dist/* /usr/local/apache2/htdocs/
RUN rm -rf /tmp/openchirp-website

# application's default port
#EXPOSE 80