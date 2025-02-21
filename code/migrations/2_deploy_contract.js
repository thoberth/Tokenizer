var MyToken = artifacts.require("MyToken");

module.exports = function (deployer) {
  const initialSupply = 100000000; // Définissez votre approvisionnement initial
  deployer.deploy(MyToken, initialSupply);
};
