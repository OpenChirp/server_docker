# Pull prebuilt openchirp web image from docker hub(built from httpd/Dockerfile)
FROM openchirp/web
ARG servername
ENV HOST=$servername

RUN cp -R /openchirp/* /run/
RUN sed -i "s/localhost/$HOST/g" /run/src/app/config.ts
WORKDIR /run
RUN ng build --prod --aot
RUN cp -R /run/dist/* /usr/local/apache2/htdocs/
