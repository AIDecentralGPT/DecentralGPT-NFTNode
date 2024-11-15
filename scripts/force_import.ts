
// const { ethers, upgrades } = require("hardhat");


async function main() {
    const contractFactory = await ethers.getContractFactory("DGCNode");

    const r = await upgrades.forceImport(
        process.env.PROXY_CONTRACT,
        contractFactory
    )
    r.waitForDeployment()
}

main().catch((error) => {
    console.error(error);
    process.exitCode = 1;
});