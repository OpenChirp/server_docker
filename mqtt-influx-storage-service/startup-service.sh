#!/bin/bash

# TODO: Hackish.. Creating admin user in service since this is the first place we need this user.
# Ideally admin user and other seeding of data should happen in a separate container

# Create Admin User
curl -s -H "Content-Type: application/json" \
    -XPOST http://rest:10010/auth/signup \
        -d @- <<EOF
{
    "email": "admin6@test.com",
    "name": "Admin",
    "password": "${ADMIN_PASSWORD}"
}
EOF
# Get Session cookie
curl -v -H "Content-Type: application/json" \
    -XPOST http://rest:10010/auth/basic -c cookie.txt \
            -d @- <<EOF
{
    "username": "admin6@test.com",
    "password": "${ADMIN_PASSWORD}"
}
EOF

curl -v -H "Content-Type: application/json" \
    -XPOST http://rest:10010/api/location -b cookie.txt \
            -d @- <<EOF
{
        "name": "root",
        "type": "OUTDOOR"
}
EOF


