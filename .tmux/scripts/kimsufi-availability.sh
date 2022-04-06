#!/usr/bin/env bash

if ! command -v jq &>/dev/null; then
  echo "missing jq!"
  exit 1
fi

TMP_FILE=/tmp/kimsufi_availability
SECONDS_TO_CACHE=60
HARDWARES=$@

function is_cache_valid {
  if ! test -f $TMP_FILE; then
    false
  fi

  current_ts=$(date +%s)
  cached_ts=$(cat $TMP_FILE | jq '.timestamp')
  seconds_past_since_cached=$((current_ts - cached_ts))

  if [ $seconds_past_since_cached -lt $SECONDS_TO_CACHE ]; then
    true
  else
    false
  fi
}

if is_cache_valid; then
  response="$(cat $TMP_FILE | jq -r '.response')"
else
  response="$(curl -s 'https://www.ovh.com/engine/api/dedicated/server/availabilities?country=ie')"
  echo "$response" | jq "{response: ., timestamp: $(date +%s)}" > $TMP_FILE
fi

for hardware in ${HARDWARES[@]}; do
  availability="$(echo "$response" | jq ".[] | select(.hardware==\"$hardware\") | select(.datacenters[].availability != \"unavailable\")")"

  if [[ ! -z "$availability" ]]; then
    pretty_hardware="$hardware"
    # hardware codes for cheapest hardwares
    [ "${pretty_hardware}" == 2201sk010 ] && pretty_hardware="KS-1"
    [ "${pretty_hardware}" == 2201sk011 ] && pretty_hardware="KS-2"
    [ "${pretty_hardware}" == 2201sk012 ] && pretty_hardware="KS-3"
    echo -n "KIMSUFI: $pretty_hardware "
  fi
done
