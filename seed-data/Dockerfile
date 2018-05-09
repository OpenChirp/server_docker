FROM python:3-alpine
# The seed_data script generates the tokens and puts them in the tokens folder
RUN mkdir /tokens
# change working directory
WORKDIR /run
COPY seed_data.sh /run/
COPY wait-for-it.sh /run/
RUN chmod +x /run/wait-for-it.sh
RUN chmod +x /run/seed_data.sh
CMD ["/run/wait-for-it.sh", "rest:10010", "--","/bin/bash", "/run/seed_data.sh"]
