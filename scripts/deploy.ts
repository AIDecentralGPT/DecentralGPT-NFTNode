
import dotenv from 'dotenv';
const {ethers} = require("hardhat");
dotenv.config();

async function main() {
    const contractFactory = await ethers.getContractFactory("DGCNode");
    const upgrade = await upgrades.deployProxy(
        contractFactory ,
        [process.env.OWNER],
        { initializer: 'initialize' },
        { txOverrides: {gasLimit: 300000}}
    );
    console.log("deployed to:", upgrade.target);
}

main().catch((error) => {
    console.error(error);
    process.exitCode = 1;
});