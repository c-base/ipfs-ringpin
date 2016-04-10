# ipfs-ringpin

File-sharing ring for [IPFS](https://ipfs.io/ "The InterPlanetary File System"), implemented using [IPNS](https://github.com/ipfs/examples/tree/master/examples/ipns "The Inter-Planetary Naming System") and pinning.

## Status
Experimental.

## Background

IPFS implements a content-addressable, peer2peer file system.
As long as some node in the network has the data associated with an address (hash), the object can be retrieved.
If however no-one has the data, either right now or over an extended period of time, there is no way to get it.

*Pinning* is the IPFS way for *a node* to mark an object for keeping (not ephemeral cache).
However, this is only for a single node. If this node goes down or looses connectivity, there is no guarantee that anyone else has the data.

For reliable serving of files, it is necessary to ensure a level of redundancy.

In **ringpin**, each of the members of the ring follows what the other members have pinned, and also pins those.

## Implementation

Each member node

* Publishes on `/ipns/$nodeid/pinlist/$topic`, an IPFS object with links to objects to pin (and that it has pinned)
* Has a list of URLs of this form, from other nodes.
* Periodically runs a cronjob, iterates over each of entries in the list, and then recursively pins the object

Each node may have multiple topics. A topic may exist in many topic lists.

Because only the node (someone with its private key) can update the IPNS entry,
this setup ensures that only a trusted set of peers can cause your node to pin items.

The topic list is proposed held in a git repository, and changes made via git pull requests.
Individual nodes can fork and change this at will.

There is no verification of the quality-of-service provided in this network "best effort".

## Future

* Allow to publish IPNS entries using public/private keypairs different from that of the node.
Then it becomes possible to have one keypair per topic, instead of just per node.
Useful if needing to revoke trust.

## Initialization

You need to have prepared an IPNS entry for your node before running these tools. If you haven't done so earlier, it is possible to get it going by running:

    ipfs name publish QmUNLLsPACCz1vLxQVkXqqLX5R1X345qqfHbsf67hvA3Nn

This will post an entry containing an empty directory, which can then be amended with real contents.

## Publishing new information

To publish new pinned information to the network, you need to first add and pin it locally.
Then using the hash, publish it to your IPNS entry with the [publish-hash.sh](../master/tools/publish-hash.sh) tool.

Example:

    ./tools/publish-hash.sh QmRgsjHhD6WD1s43B1PU6Va9qg2TP4M6swN48Fc2DNCQTx pinlist/videos/some-event

This will update your IPNS entry, and others can pin it either using your node identifier or that and a path.

## Add your topic to one or more pinlists

To have other nodes pin your things, you must add it to a pinlist which many nodes share.

Example for the topic `/pinlist/videos`:

    echo /ipns/$(ipfs id -f="<id>")/pinlist/videos

For now we have [some lists in this project](https://github.com/c-base/ipfs-ringpin/tree/master/lists).
You may submit [pull requests](https://github.com/c-base/ipfs-ringpin/pulls) against this repo.

## Keeping your IPNS entry alive

By default IPNS entries expire every 24h. To refresh yours, run this from cron:

    ./tools/publish-ipns.sh

## Updating pins

To update what your node has pinned to match that specify by other nodes.

    ./tools/pin-list.sh lists/mylist.pinlist

The list can be one of the [lists in this project](https://github.com/c-base/ipfs-ringpin/tree/master/lists).
