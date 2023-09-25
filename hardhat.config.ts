require("dotenv").config();
require("@nomiclabs/hardhat-ethers");
require("@nomiclabs/hardhat-etherscan");

const GOERLI_API_KEY = "VsuuVhl1VyMe24RJuat_I55RGD9c49le";
const MAINNET_API_KEY = "259a2Dg5ct1eY7O0kdUUwze5byAg8hdu";
const SEPOLIA_API_KEY = "LN6j7rDGkKgLlepbZPx1sc7jurrE47iF";

module.exports = {
  solidity: "0.8.9",

  networks: {
    mainnet: {
      url: `https://eth-mainnet.g.alchemy.com/v2/${MAINNET_API_KEY}`,
      accounts: [`0x` + process.env.PRIVATE_KEY],
      chainId: 1,
    },
    goerli: {
      url: `https://eth-goerli.g.alchemy.com/v2/${GOERLI_API_KEY}`,
      accounts: [`0x` + process.env.PRIVATE_KEY],
      chainId: 5,
    },
    sepolia: {
      url: `https://eth-sepolia.g.alchemy.com/v2/{SEPOLIA_API_KEY}`,
      accounts: [`0x` + process.env.PRIVATE_KEY],
      chainId: 11155111,
    },
    bsctestnet: {
      url: `https://data-seed-prebsc-1-s1.binance.org:8545`,
      accounts: [`0x` + process.env.PRIVATE_KEY],
      chainId: 97
    },
  },
  etherscan: {
    apiKey: "4WZRJ7TWX3E899YGG1IBAYKC27HUTN1MRP"
  },
};