#!/bin/bash

ncz() {
  OPTIND=1 ; while getopts ":hv" opt; do
    case ${opt} in
      v) VERBOSE=true
         ;;
      h|\?) printf "Usage: $0 [-v] <host | host:port>" ; return
         ;;
     esac
  done
  shift $(($OPTIND - 1))
  HOST=${1%:*}
  PORT=${1#*:}
  PORT=${2:-$PORT}
  (exec 6<>/dev/tcp/${HOST}/${PORT} 2>&1)
  RC=$?
  case "${VERBOSE}${RC}" in
    true0) printf "open\n";;
    true*) printf "closed\n";;
  esac
  return $RC
}

