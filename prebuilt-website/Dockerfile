# Pull prebuilt openchirp web image from docker hub(built from httpd/Dockerfile) and update hostname if set
FROM openchirp/web
ARG servername
RUN export HOST=$servername
COPY update-hostname.sh /run/
RUN chmod +x /run/update-hostname.sh
RUN /run/update-hostname.sh