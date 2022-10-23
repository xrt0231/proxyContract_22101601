import { HardhatUserConfig } from "hardhat/config";
import "@nomicfoundation/hardhat-toolbox";
import '@openzeppelin/hardhat-upgrades'; 
import '@nomiclabs/hardhat-ethers';
import * as dotenv from 'dotenv';
import '@nomiclabs/hardhat-etherscan';

dotenv.config();

const config: HardhatUserConfig = {
  solidity: "0.8.17",
  networks: {
    goerli: {
      url: `${process.env.URL}`,
      accounts: [`${process.env.PK}`],
    }
  },
  etherscan: {
    apiKey: process.env.API_KEY,
  },
};

//console.log(config.networks);

export default config;
