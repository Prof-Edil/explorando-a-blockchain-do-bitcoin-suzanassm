# Create a 1-of-4 P2SH multisig address from the public keys in the four inputs of this tx:
#   `37d966a263350fe747f1c606b159987545844a493dd38d84b070027a895c4517`
RPC_CONNECT="84.247.182.145"
RPC_USER="user_261"
RPC_PASSWORD="Uu6LBPhhk9Fr"
#!/bin/bash

txid="37d966a263350fe747f1c606b159987545844a493dd38d84b070027a895c4517"

raw_tx=$(bitcoin-cli -rpcconnect=$RPC_CONNECT -rpcuser=$RPC_USER -rpcpassword=$RPC_PASSWORD getrawtransaction "$txid")

decoded_tx=$(bitcoin-cli -rpcconnect=$RPC_CONNECT -rpcuser=$RPC_USER -rpcpassword=$RPC_PASSWORD decoderawtransaction "$raw_tx")

pubkeys=()
for input in $(echo "$decoded_tx" | jq -c '.vin[]'); do
    txid_input=$(echo "$input" | jq -r '.txid')
    vout=$(echo "$input" | jq -r '.vout')

    prev_raw_tx=$(bitcoin-cli -rpcconnect=$RPC_CONNECT -rpcuser=$RPC_USER -rpcpassword=$RPC_PASSWORD getrawtransaction "$txid_input")
    prev_decoded_tx=$(bitcoin-cli -rpcconnect=$RPC_CONNECT -rpcuser=$RPC_USER -rpcpassword=$RPC_PASSWORD decoderawtransaction "$prev_raw_tx")

    scriptPubKey=$(echo "$prev_decoded_tx" | jq -r ".vout[$vout].scriptPubKey.asm")

    witness=$(echo "$input" | jq -r '.txinwitness')
    if [ "$witness" != "null" ]; then
        pubkey=$(echo "$witness" | jq -r '.[1]')  # Extract second witness element (public key)
        pubkeys+=("$pubkey")
    fi
done


pubkey_json=$(printf '"%s",' "${pubkeys[@]}" | sed 's/,$//')

result=$(bitcoin-cli -rpcconnect=$RPC_CONNECT -rpcuser=$RPC_USER -rpcpassword=$RPC_PASSWORD createmultisig 1 "[$pubkey_json]" "p2sh-segwit")

address=$(echo "$result" | jq -r '.address')

echo  $address


