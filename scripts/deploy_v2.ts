import { ethers, upgrades } from "hardhat";

async function main() {
 
  const PROXY = "0xc93c8caf58acf126ab971081a8e9d52d2f6465ac";
  const JToken_V2 = await ethers.getContractFactory("JToken_V2");
  const jtoken_v2 = await upgrades.upgradeProxy(PROXY, JToken_V2);

  await jtoken_v2.deployed();
  
  console.log(`JToken_V2 deployed to: ${jtoken_v2.address}`);
}

// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
