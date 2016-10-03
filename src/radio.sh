#!/bin/bash

function stop {
  if [ -f ${BASH_SOURCE%/*}/radio.pid ]; then
    kill $(cat ${BASH_SOURCE%/*}/radio.pid) ; \
      rm ${BASH_SOURCE%/*}/radio.pid
  fi
}

function play {
  stop
  nohup mpg321 "$1" >/dev/null 2>&1 &
  echo $!>${BASH_SOURCE%/*}/radio.pid
}

if [[ $# -eq 0 ]] ; then
  stop
  exit 0
fi


case "$1" in
  tev) play http://stream.radiotev.lv:8002/radiov ;;
  record) play http://air2.radiorecord.ru:805/rr_320 ;;
esac
