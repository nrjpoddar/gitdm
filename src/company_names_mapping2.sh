#!/bin/bash
if ( [ -z "${SH_DSN}" ] && [ ! -z "$1" ] )
then
  export SH_DSN="`cat SH_DSN.${1}.secret`"
fi
if [ -z "${SH_DSN}" ]
then
  mysql -e "create user 'u' identified by 'p'"
  export SH_DSN='u:p@tcp(127.0.0.1:3306)/?charset=utf8'
fi
if [ ! -z "$MANUAL" ]
then
  ./map_orgs
else
  CACHED=1 TRUNC='' NO_ACQS=1 ./map_orgs && mv config.txt cncf-config/email-map && mv mapped.json github_users.json
fi
