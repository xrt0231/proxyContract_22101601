import { ethers, upgrades } from "hardhat";

async function main() {
 
  const JToken = await ethers.getContractFactory("JToken");
  const jtoken = await upgrades.deployProxy(JToken, [42], {
    initializer: "initialize",
   });

  await jtoken.deployed();
  
  console.log(`JToken deployed to: ${jtoken.address}`);
}

// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
