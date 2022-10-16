import { expect } from "chai";
import { ethers, upgrades } from "hardhat";
import { appWorksProxySol } from "../typechain-types/factories/contracts";

describe("AppWorks contract", function () {
    it('Deployment should show the total supply of tokens', async function () {
        const [owner] = await ethers.getSigners();
        const AppWorks_J = await ethers.getContractFactory("AppWorks_J")
        const appworksToken = await AppWorks_J.deploy("setNotRevealedURI");
        const ownerBalance = await appworksToken.balanceOf(owner.address);
        expect(await appworksToken.withdrawBalance()).to.equal(ownerBalance);
    })
  });