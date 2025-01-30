# Which public key signed input 0 in this tx:
#   `e5969add849689854ac7f28e45628b89f7454b83e9699e551ce14b6f90c86163`
RPC_CONNECT="84.247.182.145"  # IP do servidor RPC
RPC_USER="user_261"
RPC_PASSWORD="Uu6LBPhhk9Fr"
 # Sua senha RPC
#!/bin/bash
# Get the transaction details.
tx=$(bitcoin-cli  -rpcconnect=$RPC_CONNECT -rpcuser=$RPC_USER -rpcpassword=$RPC_PASSWORD  getrawtransaction "e5969add849689854ac7f28e45628b89f7454b83e9699e551ce14b6f90c86163" true)
# Extract the public key from input 0.
pubkey=$(echo $tx | jq -r '.vin[0].scriptSig.asm | split(" ")[1]')
echo $pubkey
