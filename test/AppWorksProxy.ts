import { expect } from "chai";
import { ethers, upgrades } from "hardhat";

//Start test block
describe("AppWorks contract", async function () {
    beforeEach(async function() {
        const AppWorks_J = await ethers.getContractFactory("AppWorks_J")
        const appworks_j = await upgrades.deployProxy(AppWorks_J,[100], { initializer: 'retrieve'});

        //Test case
        it('retrieve returns a value previously initialized', async function () {
            //Test if the returned value is the same one
            //Note that we need to use strings to compare the 256 bit integers
            expect(await appworks_j.retrieve()).to.equal('100');
        })
    })
});