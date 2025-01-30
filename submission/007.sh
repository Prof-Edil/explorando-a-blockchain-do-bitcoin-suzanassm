# Only one single output remains unspent from block 123,321. What address was it sent to?
RPC_CONNECT="84.247.182.145"
RPC_USER="user_261"
RPC_PASSWORD="Uu6LBPhhk9Fr"
BLOCK_HEIGHT=123321        # Altura do bloco desejado

#!/bin/bash
# Get the block hash for block 123,321.
blockhash=$(bitcoin-cli  -rpcconnect=$RPC_CONNECT -rpcuser=$RPC_USER -rpcpassword=$RPC_PASSWORD getblockhash 123321)
# Get the block details.
block=$(bitcoin-cli  -rpcconnect=$RPC_CONNECT -rpcuser=$RPC_USER -rpcpassword=$RPC_PASSWORD  getblock $blockhash 2)
# Get all transaction IDs in the block.
txids=$(echo $block | jq -r '.tx[] | .txid')
# Loop through each transaction to find unspent outputs.
for txid in $txids; do
    tx=$(bitcoin-cli   -rpcconnect=$RPC_CONNECT -rpcuser=$RPC_USER -rpcpassword=$RPC_PASSWORD getrawtransaction $txid true)
    vouts=$(echo $tx | jq -r '.vout[] | select(.spent == false) | .scriptPubKey.address')
    if [ ! -z "$vouts" ]; then
        echo $vouts
        break
    fi
done
