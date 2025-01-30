# Create a 1-of-4 P2SH multisig address from the public keys in the four inputs of this tx:
#   `37d966a263350fe747f1c606b159987545844a493dd38d84b070027a895c4517`
RPC_CONNECT="84.247.182.145"
RPC_USER="user_261"
RPC_PASSWORD="Uu6LBPhhk9Fr"
tx=$(bitcoin-cli -rpcconnect=$RPC_CONNECT -rpcuser=$RPC_USER -rpcpassword=$RPC_PASSWORD getrawtransaction "37d966a263350fe747f1c606b159987545844a493dd38d84b070027a895c4517" true)
pubkeys=$(echo $tx | jq -r '.vin[] | select(.scriptSig.asm != null) | .scriptSig.asm | split(" ")[1]')
multisig=$(bitcoin-cli -rpcconnect=$RPC_CONNECT -rpcuser=$RPC_USER -rpcpassword=$RPC_PASSWORD createmultisig 1 "$pubkeys")
echo $multisig | jq -r .address
