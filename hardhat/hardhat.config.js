require("@nomicfoundation/hardhat-toolbox");
require("@nomicfoundation/hardhat-chai-matchers");
require("@nomiclabs/hardhat-ethers");
require("@nomicfoundation/hardhat-ignition-ethers");

/** @type import('hardhat/config').HardhatUserConfig */
module.exports = {
  solidity: "0.8.24",
  networks: {
    localhost: {
      url: "http://127.0.0.1:8545"
    },
    gethDev: {
      url: "http://127.0.0.1:8552",
      accounts: ["0x609298a69524349b0b85d8ad275d87c8321c7072affa5126821a5689640aa5e3"]
    }
  },
  ignition: {
    defaultNetwork: "gethDev"
  }
};

