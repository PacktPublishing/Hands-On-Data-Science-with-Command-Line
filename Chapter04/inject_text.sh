#!/bin/bash

lineinfile() {
  FILE=$1 ; shift
  LINE=”^$1$” ; shift
  CONTEXT=”$1.*” ; shift
  MODE=${1:-add} ; shift
  case “${MODE}” in
    add)
      grep -s “${LINE}” “${FILE}” || sed -i -e “s/\(${CONTEXT}\)/\1\n${LINE}/” “${FILE}”
      ;;
    del)
      grep -s “${LINE}” “${FILE}” || sed -i -e “/${LINE}/d” “${FILE}”
      ;;
  esac
}

