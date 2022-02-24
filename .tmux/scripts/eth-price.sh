#!/usr/bin/env bash

if ! command -v jq &>/dev/null; then
  echo "missing jq!"
  exit 1
fi

TMP_FILE=/tmp/tmux-eth-price
SECONDS_TO_CACHE=60

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
  price="$(cat $TMP_FILE | jq '.price')"
  variation="$(cat $TMP_FILE | jq '.variation')"
else
  price=$(curl -s https://api.kraken.com/0/public/Ticker\?pair\=ETHEUR | jq '.result.XETHZEUR.a[0]' | sed 's/\"//g')
  variation=$(curl -s https://data.messari.io/api/v1/assets/eth/metrics/market-data)
  jq -n "{price: $price, variation: $variation, timestamp: $(date +%s)}" > $TMP_FILE
fi

hour_variation=$(echo ${variation} | jq '.data.market_data.percent_change_usd_last_1_hour' | awk '{printf "%.2f", $1}')
day_variation=$(echo ${variation} | jq '.data.market_data.percent_change_usd_last_24_hours' | awk '{printf "%.2f", $1}')

if [[ $price == "" ]]; then
  echo "internet?"
  exit 1
else
  price=$(echo ${price} | bc -l | awk '{printf "%.2f", $1}')
  echo ETH: "${price}€ (H: ${hour_variation}% | D: ${day_variation}%)"
fi
