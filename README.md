# ipfs-ringpin
A-ringa-pin-ping-a-ringa-pin-pong

File-sharing ring for [IPFS](https://ipfs.io/), implemented using IPNS and pinning.

## Background

IPFS implements a content-addressable, peer2peer filesystem.
As long as some node in the network has the data associated with an address (hash), the object can be retrieved.
If however no-one has the data, either right now or over an extended period of time, there is no way to get it.

*Pinning* is the IPFS way for *a node* to mark an object for keeping (not emphemeral cache).
However, this is only for a single node. If this node goes down or looses connectivity, there is
no guarantee that anyone else has the.

For reliable serving of files, it is neccesary to ensure a level of redundancy.

In ringpin, each of the members of the ring follows what the other members have pinned, and also pins those.

## Status
Just words
