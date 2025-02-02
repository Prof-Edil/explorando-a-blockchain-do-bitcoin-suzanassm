# Only one single output remains unspent from block 123,321. What address was it sent to?
# Only one single output remains unspent from block 123,321. What address was it sent to?
RPC_CONNECT="84.247.182.145"
RPC_USER="user_261"
RPC_PASSWORD="Uu6LBPhhk9Fr"

blockhash=$(bitcoin-cli -rpcconnect=$RPC_CONNECT -rpcuser=$RPC_USER -rpcpassword=$RPC_PASSWORD getblockhash 123321)

block=$(bitcoin-cli -rpcconnect=$RPC_CONNECT -rpcuser=$RPC_USER -rpcpassword=$RPC_PASSWORD getblock $blockhash)

txids=$(echo "$block" | jq -r '.tx[]')

echo "$txids" | while read -r txid; do

  tx=$(bitcoin-cli -rpcconnect=$RPC_CONNECT -rpcuser=$RPC_USER -rpcpassword=$RPC_PASSWORD getrawtransaction "$txid" true)

  echo "$tx" | jq -c '.vout[]' | while read -r vout; do
    index=$(echo "$vout" | jq -r '.n')  # Get the output index
    address=$(echo "$vout" | jq -r '.scriptPubKey.address')

    utxo=$(bitcoin-cli -rpcconnect=$RPC_CONNECT -rpcuser=$RPC_USER -rpcpassword=$RPC_PASSWORD gettxout "$txid" "$index")

    if [ ! -z "$utxo" ] && [ "$address" != "null" ]; then
      echo "$address" 
    fi
  done
done

