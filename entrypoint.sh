#!/bin/sh -l

export AKASH_NET="https://raw.githubusercontent.com/ovrclk/net/master/mainnet"
export AKASH_VERSION="$(curl -s "$AKASH_NET/version.txt")"
export AKASH_NODE="$(curl -s "$AKASH_NET/rpc-nodes.txt" | shuf -n 1)"

echo "::set-output name=cli-version::"$(akash version)
echo "::set-output name=network::"$AKASH_NET
echo "::set-output name=network-version::"$AKASH_VERSION
echo "::set-output name=network-node::"$AKASH_NODE

echo "$1" >> /tmp/akash_wallet_key.txt
echo $(echo "$2" | sed 's/./& /g') | sed 's/ //g' >> /tmp/akash_wallet_key_password.txt
export AKASH_WALLET_KEY_PASSWORD=$(cat /tmp/akash_wallet_key_password.txt)

echo $AKASH_WALLET_KEY_PASSWORD

yes  | akash keys import "AKASH_GROWTH_GROUP" /tmp/akash_wallet_key.txt

# akash keys show "$AKASH_KEY_NAME