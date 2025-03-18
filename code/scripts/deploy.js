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