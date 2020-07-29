#!/bin/bash

# Reduce maximum number of number of open file descriptors to 1024
# otherwise slapd consumes two orders of magnitude more of RAM
# see https://github.com/docker/docker/issues/8231
ulimit -n 1024

ldapsearch -x -D cn=Manager,dc=example,dc=com -w admin

OPENLDAP_ROOT_PASSWORD=${OPENLDAP_ROOT_PASSWORD:-admin}
OPENLDAP_ROOT_DN_PREFIX=${OPENLDAP_ROOT_DN_PREFIX:-'cn=Manager'}
OPENLDAP_ROOT_DN_SUFFIX=${OPENLDAP_ROOT_DN_SUFFIX:-'dc=example,dc=com'}
OPENLDAP_DEBUG_LEVEL=${OPENLDAP_DEBUG_LEVEL:-256}
OPENLDAP_LISTEN_URIS=${OPENLDAP_LISTEN_URIS:-"ldaps:/// ldap:///"}

# Start the slapd service
exec slapd -h "${OPENLDAP_LISTEN_URIS}" -d $OPENLDAP_DEBUG_LEVEL
