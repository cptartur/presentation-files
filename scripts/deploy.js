async function main() {
    const Voting = await ethers.getContractFactory("Voting");

    const estimateGas = await ethers.provider.estimateGas(Voting.getDeployTransaction())
    console.log(estimateGas)

    const voting = await Voting.deploy({gasPrice: estimateGas});
    console.log("Contract deployed to address:", voting.address);
}

main()
    .then(() => process.exit(0))
    .catch(error => {
        console.error(error);
        process.exit(1);
    });