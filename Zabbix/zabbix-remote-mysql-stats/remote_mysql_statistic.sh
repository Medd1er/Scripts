#!/bin/bash
if [[ -z "$1" || -z "$2" ]]; then
  exit 1
fi
#
# Variables
#
RESERVED="$1"
METRIC="$2"
USER="${3:-user}"
PASS="${4:-pass}"
HOST="${5:-host}"
MYSQLADMIN="/usr/bin/mysqladmin"
MYSQL="/usr/bin/mysql"
CACHE_TTL="55"
CACHE_FILE="/tmp/zabbix.remote-mysql-stats-${HOST}.cache"
EXEC_TIMEOUT="1"
NOW_TIME=`date '+%s'`
if [ "${METRIC}" = "alive" ]; then
  ${MYSQLADMIN} -h${HOST} -u${USER} -p${PASS} ping | grep alive | wc -l | head -n1
  exit 0
fi
if [ "${METRIC}" = "version" ]; then
  ${MYSQL} -h${HOST} -V | sed -e 's/^.*\(ver.*\)$/\1/gI' | head -n1
  exit 0
fi
#
if [ -s "${CACHE_FILE}" ]; then
  CACHE_TIME=`stat -c"%Y" "${CACHE_FILE}"`
else
  CACHE_TIME=0
fi
DELTA_TIME=$((${NOW_TIME} - ${CACHE_TIME}))
#
if [ ${DELTA_TIME} -lt ${EXEC_TIMEOUT} ]; then
  sleep $((${EXEC_TIMEOUT} - ${DELTA_TIME}))
elif [ ${DELTA_TIME} -gt ${CACHE_TTL} ]; then
  echo "" >> "${CACHE_FILE}" # !!!
  DATACACHE=`${MYSQLADMIN} -h${HOST} -u${USER} -p${PASS} extended-status 2>&1`
  echo "${DATACACHE}" > "${CACHE_FILE}" # !!!
  chmod 640 "${CACHE_FILE}"
fi
#
cat "${CACHE_FILE}" | grep -iw "$METRIC" | cut -d'|' -f3 | head -n1
#
exit 0
