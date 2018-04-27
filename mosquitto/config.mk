# Select your backends from this list
BACKEND_CDB ?= no
BACKEND_MYSQL ?= no
BACKEND_SQLITE ?= no
BACKEND_REDIS ?= no
BACKEND_POSTGRES ?= no
BACKEND_LDAP ?= no
BACKEND_HTTP ?= no
BACKEND_JWT ?= no
BACKEND_MONGO ?= yes
BACKEND_FILES ?= yes

# Specify the path to the Mosquitto sources here
# MOSQUITTO_SRC = /usr/local/Cellar/mosquitto/1.4.12
MOSQUITTO_SRC = /usr/local/src/mosquitto-1.4.14

# Specify the path the OpenSSL here
OPENSSLDIR = /usr/sbin

# Specify optional/additional linker/compiler flags here
# On macOS, add 
#	CFG_LDFLAGS = -undefined dynamic_lookup
# as described in https://github.com/eclipse/mosquitto/issues/244
#
# CFG_LDFLAGS = -undefined dynamic_lookup  -L/usr/local/Cellar/openssl/1.0.2l/lib
# CFG_CFLAGS = -I/usr/local/Cellar/openssl/1.0.2l/include -I/usr/local/Cellar/mosquitto/1.4.12/include
CFG_LDFLAGS =
CFG_CFLAGS =
