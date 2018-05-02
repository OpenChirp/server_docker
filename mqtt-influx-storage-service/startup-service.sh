#!/bin/bash

# TODO: Hackish.. Creating admin user in service since this is the first place we need this user.
# Ideally admin user and other seeding of data should happen in a separate container

# Create Admin User
curl -v -H "Content-Type: application/json" \
    -XPOST http://rest:10010/auth/signup \
        -d @- <<EOF
{
    "email": "admin@localhost.com",
    "name": "Openchirp Admin",
    "password": "${ADMIN_PASSWORD}"
}
EOF

# Get Session cookie
curl -v -H "Content-Type: application/json" \
    -XPOST http://rest:10010/auth/basic -c cookie.txt \
            -d @- <<EOF
{
    "username": "admin@localhost.com",
    "password": "${ADMIN_PASSWORD}"
}
EOF

# Create admin group
curl -v -H "Content-Type: application/json" \
    -XPOST http://rest:10010/api/group -b cookie.txt \
            -d @- <<EOF
{
    "name": "admin"
}
EOF

# Create developer group
curl -v -H "Content-Type: application/json" \
    -XPOST http://rest:10010/api/group -b cookie.txt \
                        -d @- <<EOF
{
    "name": "developer"
}
EOF

# Create root location
curl -v -H "Content-Type: application/json" \
    -XPOST http://rest:10010/api/location -b cookie.txt \
            -d @- <<EOF
{
    "name": "root",
    "type": "OUTDOOR"
}
EOF

# Create time series storage service
SERVICE_ID=$(curl -s -H "Content-Type: application/json" \
    -XPOST http://rest:10010/api/service -b cookie.txt \
                --data '{"name": "Timeseries storage service", "description": "This service stores transducer data in influxdb"}'  | python -c "import sys, json; print(json.load(sys.stdin)['id'])" )


# Create service token
SERVICE_TOKEN=$(curl -s -H "Content-Type: application/json" \
         -XPOST http://rest:10010/api/service/${SERVICE_ID}/token -b cookie.txt --data "{}")


#Remove double quotes from start and end of token
TOKEN=`sed -e 's/^"//' -e 's/"$//' <<<"$SERVICE_TOKEN"`


#Update service ID and its token in service configuration file
sed -e "s/SERVICE_ID/$SERVICE_ID/" /run/service.conf.start | \
    sed -e "s/PASSWORD/$TOKEN/" > /run/service.conf

#Start service
python /code/influx_service.py -f /run/service.conf
  
