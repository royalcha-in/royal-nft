require('babel-register');
require('babel-polyfill');

const HDWalletProvider = require('@truffle/hdwallet-provider');
module.exports = {
  networks: {
    rinkby:{
      provider:() => new HDWalletProvider(
        process.env.MNEMONIC,
        `https://ropsten.infura.io/v3/${process.env.INFURA_API_KEY}`
      ),
      gasPrice: 40000000000,
      network_id: 4,
      timeoutBlocks: 300,
    },
    development: {
      host: "127.0.0.1",
      port: 8545,
      network_id: "*" // Match any network id
    },
  },
  contracts_directory: './src/contracts/',
  contracts_build_directory: './src/abis/',
  compilers: {
    solc: {
      version: "0.8.6", 
      optimizer: {
        enabled: true,
        runs: 200
      }
    }
  }
}