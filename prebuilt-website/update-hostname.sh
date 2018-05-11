#!/bin/bash

# Update hostname in website if it is defined
echo $HOST
if [ -z "$HOST" ]; then
   echo "$HOSTNAME env var is not set. Website will only work with localhost"

else
	echo "Updating hostname in website config to :"$hostname
    cp src/app/config.ts src/app/config.ts.start
    sed -e "s/localhost/$HOST/" /openchirp/src/app/config.ts.start > /openchirp/src/app/config.ts
	ng build --prod --aot
	cp -R /openchirp/dist/* /usr/local/apache2/htdocs/
fi
