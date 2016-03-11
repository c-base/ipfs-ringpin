#!/bin/bash
DATE_NOW=`date`
echo "IPFS ringpin IPNS update at ${DATE_NOW}"

# Get the currently-published root hash on this node
ROOT_HASH=$(ipfs name resolve)
echo "Using latest published address ${ROOT_HASH}"
ipfs name publish $ROOT_HASH
