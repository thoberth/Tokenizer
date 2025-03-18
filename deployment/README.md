# Deploy
## BlockChain is Sepolia TestNet
We can receive faucet to deploy for free our smart contract here
https://cloud.google.com/application/web3/faucet/ethereum/sepolia

# This is the page where you can find my wallet
https://sepolia.etherscan.io/address/0x64cDe5a4bf11B094077708fB35d33002E495568B

# My smart contract can be verified here
https://sepolia.etherscan.io/token/[addressContract]

1. First we need to compile our smart contract using:

``` shell
$ npx hardhat compile
```
2. now we have to write a deploy.js (or.ts) to deploy our contract

``` solidity
async function main() {
  const [deployer] = await ethers.getSigners();
  console.log("Deploying contracts with the account:", deployer.address);

  const Token = await ethers.getContractFactory("hitmanThoberth42");
  const initialSupply = ethers.parseUnits("1000000", 18); // Example supply

  // Encode just the initialSupply parameter
  const encoded = ethers.AbiCoder.defaultAbiCoder().encode(
    ["uint256"],
    [initialSupply]
  );

  console.log("Constructor arguments:", encoded);

  // Deploy and wait for the transaction to be mined
  const hitmanThoberth = await Token.deploy(initialSupply);

  // The deployed() function is no longer used, instead just wait for the contract
  console.log(
    "hitmanThoberth42 deployed to:",
    await hitmanThoberth.getAddress()
  );
}

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });
```

The ouput should be like :
```
Deploying contracts with the account: [ContractO owner]
Constructor arguments: [Argument of the contract] (useful for verification)
hitmanThoberth42 deployed to: [address of smart contract]
```
# Test him
Then if we want to play with it on etherscan for example, we need to verify&publish contract

* if there is no import in our smart contract we can copy/Paste in etherscan.io
* if not the easiest way to do it is to use ```npx hardhat verify```
``` shell
npx hardhat verify --network sepolia [adressContract] [argumentConstructor]
```
