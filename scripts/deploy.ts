import { ethers, upgrades } from "hardhat";

async function main() {
  // const currentTimestampInSeconds = Math.round(Date.now() / 1000);
  // const ONE_YEAR_IN_SECS = 365 * 24 * 60 * 60;
  // const unlockTime = currentTimestampInSeconds + ONE_YEAR_IN_SECS;

  //const lockedAmount = ethers.utils.parseEther("0.01");

  const AppWorks_J = await ethers.getContractFactory("AppWorks_J");
  const appworks = await upgrades.deployProxy(AppWorks_J, [""]);
  // const Lock = await ethers.getContractFactory("Lock");
  //const lock = await Lock.deploy(unlockTime, { value: lockedAmount });

  await appworks.deployed();
  // await lock.deployed();

  console.log(`Lock with 0.01 ETH deployed to ${appworks.address}`);
  // console.log(`Lock with 1 ETH and unlock timestamp ${unlockTime} deployed to ${lock.address}`);
}

// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
