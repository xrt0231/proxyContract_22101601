import { HardhatUserConfig } from "hardhat/config";
import "@nomicfoundation/hardhat-toolbox";
import '@openzeppelin/hardhat-upgrades'; 
import '@nomiclabs/hardhat-ethers';
import * as dotenv from 'dotenv';

dotenv.config();

const config: HardhatUserConfig = {
  solidity: "0.8.17",
  networks: {
    goerli: {
      url: `${process.env.URL}`,
      accounts: [`${process.env.PK}`],
      // gas: "auto",
      // gasPrice: "auto",
      // from: "0x0F28506EFEeA23CEAdcBFa641337424976315B15"
    }
  },
  etherscan: {
    apiKey: process.env.API_KEY,
  },
};

//console.log(config.networks);

export default config;
