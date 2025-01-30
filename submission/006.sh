# Which tx in block 257,343 spends the coinbase output of block 256,128?
RPC_CONNECT="84.247.182.145"
RPC_USER="user_261"
RPC_PASSWORD="Uu6LBPhhk9Fr"


#!/bin/bash

coinbase_txid=$(bitcoin-cli getblock $(bitcoin-cli getblockhash 256128) | jq -r '.tx[0]')

blockhash=$(bitcoin-cli getblockhash 257343)

block=$(bitcoin-cli getblock $blockhash 2)

spending_txid=$(echo $block | jq -r --arg txid "$coinbase_txid" '.tx[] | select(.vin[].txid == $txid) | .txid')

echo $spending_txid
