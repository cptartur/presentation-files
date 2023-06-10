const API_URL = process.env.API_URL;
const PRIVATE_KEY = process.env.PRIVATE_KEY;
const CONTRACT_ADDRESS = process.env.CONTRACT_ADDRESS;

const contract = require("../artifacts/contracts/Voting.sol/Voting.json");
const {ethers} = require("ethers");

const provider = new ethers.providers.StaticJsonRpcProvider(url = API_URL, network = "sepolia");
const signer = new ethers.Wallet(PRIVATE_KEY, provider);
const votingContract = new ethers.Contract(CONTRACT_ADDRESS, contract.abi, signer);

async function main() {
    const tx = await votingContract.registerCandidate("candidate1", "0x1111111111111111111111111111111111111111");
    const tx2 = await votingContract.registerCandidate("candidate2", "0x2222222222222222222222222222222222222222");
    await Promise.all([tx, tx2]);
}

main();