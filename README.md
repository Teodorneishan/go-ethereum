## Go Ethereum

Official Golang implementation of the Ethereum protocol.

[![API Reference](
https://camo.githubusercontent.com/915b7be44ada53c290eb157634330494ebe3e30a/68747470733a2f2f676f646f632e6f72672f6769746875622e636f6d2f676f6c616e672f6764646f3f7374617475732e737667
)](https://pkg.go.dev/github.com/ethereum/go-ethereum?tab=doc)
[![Go Report Card](https://goreportcard.com/badge/github.com/ethereum/go-ethereum)](https://goreportcard.com/report/github.com/ethereum/go-ethereum)
[![Travis](https://travis-ci.com/ethereum/go-ethereum.svg?branch=master)](https://travis-ci.com/ethereum/go-ethereum)
[![Discord](https://img.shields.io/badge/discord-join%20chat-blue.svg)](https://discord.gg/nthXNEv)

Automated builds are available for stable releases and the unstable master branch. Binary
archives are published at https://geth.ethereum.org/downloads/.

## Building the source

For prerequisites and detailed build instructions please read the [Installation Instructions](https://geth.ethereum.org/docs/install-and-build/installing-geth).

Building `geth` requires both a Go (version 1.16 or later) and a C compiler. You can install
them using your favourite package manager. Once the dependencies are installed, run

```shell
make geth
```

or, to build the full suite of utilities:

```shell
make all
```

## Executables

The go-ethereum project comes with several wrappers/executables found in the `cmd`
directory.

|    Command    | Description                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          |
| :-----------: | ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
|  **`geth`**   | Our main Ethereum CLI client. It is the entry point into the Ethereum network (main-, test- or private net), capable of running as a full node (default), archive node (retaining all historical state) or a light node (retrieving data live). It can be used by other processes as a gateway into the Ethereum network via JSON RPC endpoints exposed on top of HTTP, WebSocket and/or IPC transports. `geth --help` and the [CLI page](https://geth.ethereum.org/docs/interface/command-line-options) for command line options.          |
|   `clef`    | Stand-alone signing tool, which can be used as a backend signer for `geth`.  |
|   `devp2p`    | Utilities to interact with nodes on the networking layer, without running a full blockchain. |
|   `abigen`    | Source code generator to convert Ethereum contract definitions into easy to use, compile-time type-safe Go packages. It operates on plain [Ethereum contract ABIs](https://docs.soliditylang.org/en/develop/abi-spec.html) with expanded functionality if the contract bytecode is also available. However, it also accepts Solidity source files, making development much more streamlined. Please see our [Native DApps](https://geth.ethereum.org/docs/dapp/native-bindings) page for details. |
|  `bootnode`   | Stripped down version of our Ethereum client implementation that only takes part in the network node discovery protocol, but does not run any of the higher level application protocols. It can be used as a lightweight bootstrap node to aid in finding peers in private networks.                                                                                                                                                                                                                                                                 |
|     `evm`     | Developer utility version of the EVM (Ethereum Virtual Machine) that is capable of running bytecode snippets within a configurable environment and execution mode. Its purpose is to allow isolated, fine-grained debugging of EVM opcodes (e.g. `evm --code 60ff60ff --debug run`).                                                                                                                                                                                                                                                                     |
|   `rlpdump`   | Developer utility tool to convert binary RLP ([Recursive Length Prefix](https://ethereum.org/en/developers/docs/data-structures-and-encoding/rlp)) dumps (data encoding used by the Ethereum protocol both network as well as consensus wise) to user-friendlier hierarchical representation (e.g. `rlpdump --hex CE0183FFFFFFC4C304050583616263`).                                                                                                                                                                                                                                 |
|   `puppeth`   | a CLI wizard that aids in creating a new Ethereum network.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                           |

## Running `geth`

Going through all the possible command line flags is out of scope here (please consult our
[CLI Wiki page](https://geth.ethereum.org/docs/interface/command-line-options)),
but we've enumerated a few common parameter combos to get you up to speed quickly
on how you can run your own `geth` instance.

### Hardware Requirements

Minimum:

* CPU with 2+ cores
* 4GB RAM
* 1TB free storage space to sync the Mainnet
* 8 MBit/sec download Internet service

Recommended:

* Fast CPU with 4+ cores
* 16GB+ RAM
* High Performance SSD with at least 1TB free space
* 25+ MBit/sec download Internet service

### Full node on the main Ethereum network

By far the most common scenario is people wanting to simply interact with the Ethereum
network: create accounts; transfer funds; deploy and interact with contracts. For this
particular use-case the user doesn't care about years-old historical data, so we can
sync quickly to the current state of the network. To do so:

```shell
$ geth console
```

This command will:
 * Start `geth` in snap sync mode (default, can be changed with the `--syncmode` flag),
   causing it to download more data in exchange for avoiding processing the entire history
   of the Ethereum network, which is very CPU intensive.
 * Start up `geth`'s built-in interactive [JavaScript console](https://geth.ethereum.org/docs/interface/javascript-console),
   (via the trailing `console` subcommand) through which you can interact using [`web3` methods](https://github.com/ChainSafe/web3.js/blob/0.20.7/DOCUMENTATION.md) 
   (note: the `web3` version bundled within `geth` is very old, and not up to date with official docs),
   as well as `geth`'s own [management APIs](https://geth.ethereum.org/docs/rpc/server).
   This tool is optional and if you leave it out you can always attach to an already running
   `geth` instance with `geth attach`.


### My setup and useful commands
Binaries:
- geth binary v1.10
- nodejs v20.14.0
- go version - go1.22.4

Infrastructure:
github actions using self hosted runner 
- runner configured as a service , starting the script
- Docker
- Docker compose
- build and deploy pipelines
- terraform script to create a k8s cluster in the cloud and deploys an instance of the built image to it.
 
Dockerfile - Use Base image ubuntu , install nodejs,go and geth , clone repo , compile whole repo , start private blockchain
Docker Compose - definition that runs a local devnet 
Pipelines ( .github/workflows )
- ci-build.yml - clone repository , build image , login to private docker repo and pushing ( user and password stored as secrets in github repo ). When a PR with label CI:Build is merged in v1.10 branch, a trigger kicks in.
- ci-deploy.yml - clone repository , start docker compose , docker commit and docker push the new image. When a PR with label CI:Deploy is merged in the v1.10, a pipeline is triggered.


Install npm dependencies , compile and deploy contract

```shell
npm install --save-dev --force @nomiclabs/hardhat-waffle @nomiclabs/hardhat-ethers @nomicfoundation/hardhat-ignition ethers hardhat@^2.22.5 @nomicfoundation/hardhat-toolbox@^5.0.0

npx hardhat init -y  ( still i had to press y and choose javascript project )

npx hardhat compile

npx hardhat ignition deploy ./ignition/modules/Lock.js --network gethDev
```

Create account and paste public key in genesis file to import balance
working dir go-ethereum
create password.txt and paste some password ; genesis file is also in go-ethereum;

```shell
build/bin/geth --datadir=datadir/ --password ./password.txt account new > account3.txt
```

Public address of the key:   0x595554F77a5cf179749a2845F3f74E50F36461c5

Paste public address in go-ethereum/genesis.json



Gather private key with this script  - serves the configuration file for the Hardhat environment, in the specified getDev private network

Install prerequisites for using the script. 

```shell
npm install ethereumjs-wallet keythereum --legacy-peer-deps
```
edin script (const keystoreDir = path.join(__dirname, 'datadir', 'keystore'); - replace datadir to what you want.

```shell
node extractPrivateKey.js 
```


@@@@@@ Private key: 0xd3d245fd385b65ed722a4b91dcf6691c0a8aaf4a542edfba80f53d077fc504d1  @@@@@@

paste in hardhat/hardhat.config.js



Removing db ( we can do it anytime , and only need to initiate private blockchain with genesis again )

```shell
cd datadir/geth
rm -rf chaindata/ lightchaindata/
build/bin/geth removedb
```


Initializing the private blockchain
```shell
build/bin/geth --datadir ./datadir init genesis.json
```




when starting node , chain data is created.
```shell
build/bin/geth --datadir datadir --port 30304 --http --http.addr "localhost" --http.port 8552 --http.api "personal,eth,web3,txpool,admin" --syncmode=full --networkid 2345 --allow-insecure-unlock --authrpc.port 8553 --nodiscover --miner.gaslimit 8000000 console
```


If we want to start mining

```shell
build/bin/geth attach http://127.0.0.1:8552 <<EOF
miner.start()
EOF
```

To stop mining

```shell
miner.stop()
```



In console , usefull commands , we can check:

```shell
build/bin/geth console
- check account being used - eth.accounts[0]
- check balance of that account - eth.getBalance(eth.accounts[0])
- check pending transactions - eth.pendingTransactions 
```

We can run separately the docker with
```shell
docker run -it -d -p 30304:30304 -p 8552:8552 -p 8553:8553 image_name
```
