import { expect } from "chai";
import { ethers, upgrades } from "hardhat";

//Start test block
describe("AppWorks contract", async function () {
    //Test case
    it('retrieve returns a value previously initialized', async function () {
        const JToken = await ethers.getContractFactory("JToken");
        const jtoken = await AppWorks.deploy();
        //Test if the returned value is the same one
        //Note that we need to use strings to compare the 256 bit integers
        expect(await jtoken.retrieve(42)).to.equal('42');
    })
});