# What is the hash of block 654,321?
#!/bin/bash
# Get the hash of block 654,321 using the getblockhash RPC command.
blockhash=$(bitcoin-cli getblockhash 654321)
echo $blockhash
