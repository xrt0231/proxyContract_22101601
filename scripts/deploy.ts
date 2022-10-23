import { ethers, upgrades } from "hardhat";

async function main() {
 
  const AppWorks_J_V1 = await ethers.getContractFactory("AppWorks_J_V1");
  const appworks = await upgrades.deployProxy(AppWorks_J_V1, [42], {
    initializer: "initialize",
   });

  await appworks.deployed();
  
  console.log(`Lock with 0.01 ETH deployed to ${appworks.address}`);
}

// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
