FROM python:3-alpine
RUN apk add --update --no-cache \
        bash ca-certificates curl
# change working directory
WORKDIR /run
# The seed_data script generates the tokens and puts them in the tokens folder
RUN mkdir /tokens
COPY seed_data.sh /run/
COPY wait-for-it.sh /run/
RUN chmod +x /run/wait-for-it.sh
RUN chmod +x /run/seed_data.sh
#Wait for the rest api server to be truly ready before starting the seed data script
CMD ["/run/wait-for-it.sh", "rest:10010", "--","/bin/bash","/run/seed_data.sh"]
