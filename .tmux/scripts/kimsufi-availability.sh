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
  response="$(curl -s 'https://www.ovh.com/engine/api/dedicated/server/availabilities')"
  echo "$response" | jq "{response: ., timestamp: $(date +%s)}" > $TMP_FILE
fi

for hardware in ${HARDWARES[@]}; do
  availability="$(echo "$response" | jq ".[] | select(.hardware==\"$hardware\") | select(.datacenters[].availability != \"unavailable\")")"

  if [[ ! -z "$availability" ]]; then
    echo -n "KIMSUFI: $hardware "
  fi
done
