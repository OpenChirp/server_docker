#!/bin/bash
# This script seeds the following data:
# 1. User: a user with email admin@localhost.com
# 2. Groups: admin and developer
# 3. Location: a location with name "root" ( so that the location tree shows up in left menu on website)
# 4. Storage service and its token(stored in file to be read later by storage service container)
# 5. Mapper service and its token(stored in file to be read later by mapper service container)

# Create Admin User
curl -s -H "Content-Type: application/json" \
    -XPOST http://rest:10010/auth/signup \
        -d @- <<EOF
{
    "email": "admin@localhost.com",
    "name": "Openchirp Admin",
    "password": "${ADMIN_PASSWORD}"
}
EOF

# Get Session cookie
curl -s -H "Content-Type: application/json" \
    -XPOST http://rest:10010/auth/basic -c cookie.txt \
            -d @- <<EOF
{
    "username": "admin@localhost.com",
    "password": "${ADMIN_PASSWORD}"
}
EOF

# Create admin group
curl -s -H "Content-Type: application/json" \
    -XPOST http://rest:10010/api/group -b cookie.txt \
            -d @- <<EOF
{
    "name": "admin"
}
EOF

# Create developer group
curl -s -H "Content-Type: application/json" \
    -XPOST http://rest:10010/api/group -b cookie.txt \
                        -d @- <<EOF
{
    "name": "developer"
}
EOF

# Create root location
curl -s -H "Content-Type: application/json" \
    -XPOST http://rest:10010/api/location -b cookie.txt \
            -d @- <<EOF
{
    "name": "root",
    "type": "OUTDOOR"
}
EOF

# Create time series storage service
SS_SERVICE_ID=$(curl -s -H "Content-Type: application/json" \
    -XPOST http://rest:10010/api/service -b cookie.txt \
                --data '{"name": "Timeseries storage service", "description": "This service stores transducer data in influxdb"}'  | python -c "import sys, json; print(json.load(sys.stdin)['id'])" )

echo "SERVICE_ID="$SS_SERVICE_ID > /tokens/storage_service.token

# Create storage service token
SS_SERVICE_TOKEN=$(curl -s -H "Content-Type: application/json" \
         -XPOST http://rest:10010/api/service/${SS_SERVICE_ID}/token -b cookie.txt --data "{}")


#Remove double quotes from start and end of token
SS_TOKEN=`sed -e 's/^"//' -e 's/"$//' <<<"$SS_SERVICE_TOKEN"`

echo "SERVICE_TOKEN="$SS_TOKEN >> /tokens/storage_service.token

# Create mapper service
MP_SERVICE_ID=$(curl -s -H "Content-Type: application/json" \
    -XPOST http://rest:10010/api/service -b cookie.txt \
                --data '{"name": "GPS Mapper ", "description": "Display GPS tagged devices publicly on landing page map"}'  | python -c "import sys, json; print(json.load(sys.stdin)['id'])" )

echo "SERVICE_ID="$MP_SERVICE_ID > /tokens/mapper_service.token

# Create mapper service token
MP_SERVICE_TOKEN=$(curl -s -H "Content-Type: application/json" \
         -XPOST http://rest:10010/api/service/${MP_SERVICE_ID}/token -b cookie.txt --data "{}")


#Remove double quotes from start and end of token
MP_TOKEN=`sed -e 's/^"//' -e 's/"$//' <<<"$MP_SERVICE_TOKEN"`

echo "SERVICE_TOKEN="$SERVICE_TOKEN >> /tokens/mapper_service.token

