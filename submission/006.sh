# Which tx in block 257,343 spends the coinbase output of block 256,128?
RPC_CONNECT="84.247.182.145"
RPC_USER="user_261"
RPC_PASSWORD="Uu6LBPhhk9Fr"

# Passo 1: Pegar a coinbase TXID do bloco 256,128
BLOCK_256128=$(bitcoin-cli -rpcconnect=$RPC_CONNECT -rpcuser=$RPC_USER -rpcpassword=$RPC_PASSWORD getblockhash 256128)
COINBASE_TX=$(bitcoin-cli -rpcconnect=$RPC_CONNECT -rpcuser=$RPC_USER -rpcpassword=$RPC_PASSWORD getblock $BLOCK_256128 | jq -r '.tx[0]')

echo "$COINBASE_TX"

# Passo 2: Procurar esse TXID no bloco 257,343
BLOCK_257343=$(bitcoin-cli -rpcconnect=$RPC_CONNECT -rpcuser=$RPC_USER -rpcpassword=$RPC_PASSWORD getblockhash 257343)
TXS=$(bitcoin-cli -rpcconnect=$RPC_CONNECT -rpcuser=$RPC_USER -rpcpassword=$RPC_PASSWORD getblock $BLOCK_257343 2)

SPENDING_TX=$(echo $TXS | jq -r --arg TXID "$COINBASE_TX" '.tx[] | select(.vin[].txid == $TXID) | .txid')

echo "$SPENDING_TX"
