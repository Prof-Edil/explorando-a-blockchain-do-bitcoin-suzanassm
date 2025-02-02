# How many new outputs were created by block 123,456?
RPC_CONNECT="84.247.182.145"
RPC_USER="user_261"
RPC_PASSWORD="Uu6LBPhhk9Fr"
BLOCK_HEIGHT=123456  

#!/bin/bash
# Get the block hash for block 123,456.
blockhash=$(bitcoin-cli -rpcconnect=$RPC_CONNECT -rpcuser=$RPC_USER -rpcpassword=$RPC_PASSWORD getblockhash 123456)
# Get the block details.
block=$(bitcoin-cli -rpcconnect=$RPC_CONNECT -rpcuser=$RPC_USER -rpcpassword=$RPC_PASSWORD getblock $blockhash 2)
# Use jq to count the number of outputs in all transactions in the block.
echo $block | jq '[.tx[].vout[]] | length'
