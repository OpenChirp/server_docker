FROM alpine:3.5
# change working directory
WORKDIR /run
RUN mkdir /tokens

COPY seed_data.sh /run/
COPY wait-for-it.sh /run/
RUN chmod +x /run/wait-for-it.sh
RUN chmod +x /run/seed_data.sh
CMD ["/run/wait-for-it.sh", "rest:10010", "--","/bin/bash", "/run/seed_data.sh"]
