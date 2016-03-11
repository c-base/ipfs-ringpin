#!/bin/bash
DATE_NOW=`date`
echo "IPFS ringpin publish at ${DATE_NOW}"

# Get the currently-published root hash on this node
ROOT_HASH=$(ipfs name resolve)
echo "Using latest published address ${ROOT_HASH}"

# Input data
INPUT_HASH=$1
TARGET_PATH=$2

# Show the operation we're doing
echo "Adding IPFS hash ${INPUT_HASH} as ${TARGET_PATH}"
NEW_ROOT_HASH=$(ipfs object patch $ROOT_HASH add-link $TARGET_PATH $INPUT_HASH)
echo "New root hash is ${NEW_ROOT_HASH}"
ipfs name publish $NEW_ROOT_HASH
