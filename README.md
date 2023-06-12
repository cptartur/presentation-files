# Simple Solidity Voting Contract

⚠️ This code has not been audited. Do not use in production environment.

## Metamask

Create Ethereum account on https://metamask.io/download/. Use "sepolia" testnet.

### Exporting private key from metamask

Follow this tutorial: https://metamask.zendesk.com/hc/en-us/articles/360015289632-How-to-Export-an-Account-Private-Key.

## Alchemy

Create alchemy app on https://dashboard.alchemy.com/apps and create `.env` file from `.env.template`; populate the
details from your alchemy app page.

### Top up your account

Use alchemy sepolia faucet to top up your account with Sepolia ETH

https://sepoliafaucet.com/

## Etherscan

Use to check your contract deployment, events, transactions etc.

https://sepolia.etherscan.io/

## Building and running

Install project

```shell
npm i
```

Build your contract

```shell
npx hardhat compile
```

Deploy your contract

```shell
npx hardhat run scripts/deploy.js --network sepolia
```

Interact with your contract

```shell
npx hardhat run scripts/...
```

## Exercises

1. Right now, every account can vote. Implement a solution that limit voters to addresses manually approved by the
   owner.
2. Extend candidate struct so it includes a `bio` section. Add method that allows candidates to update their bios.