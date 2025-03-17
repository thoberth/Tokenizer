require("@nomicfoundation/hardhat-toolbox");
require("@nomicfoundation/hardhat-verify");
require("dotenv").config();

module.exports = {
  solidity: "0.8.29",
  networks: {
    sepolia: {
      url: `https://sepolia.infura.io/v3/${process.env.YOUR_INFURA_PROJECT_ID}`, // Remplace par ton Infura Project ID
      accounts: [`0x${process.env.ACCOUNT_PRIVATE_KEY}`]
    }
  },
  etherscan: {
    // Your API key for Etherscan
    // Obtain one at https://etherscan.io/
    apiKey: `${process.env.YOUR_ETHERSCAN_API_KEY}`
  },
  sourcify: {
    // Disabled by default
    // Doesn't need an API key
    enabled: true
  }
};