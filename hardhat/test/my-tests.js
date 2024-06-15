const { expect } = require("chai");
const { ethers } = require("hardhat");
const { time } = require("@nomicfoundation/hardhat-network-helpers");

describe("Lock", function () {
  it("Should set the right unlockTime", async function () {
    const lockedAmount = ethers.utils.parseEther("1.0"); // 1 ether
    const ONE_YEAR_IN_SECS = 365 * 24 * 60 * 60;
    const unlockTime = (await time.latest()) + ONE_YEAR_IN_SECS;

    // deploy a lock contract where funds can be withdrawn one year in the future
    const Lock = await ethers.getContractFactory("Lock");
    const lock = await Lock.deploy(unlockTime, { value: lockedAmount });
    await lock.deployed();

    // assert that the value is correct
    expect(await lock.unlockTime()).to.equal(unlockTime);
  });
});

