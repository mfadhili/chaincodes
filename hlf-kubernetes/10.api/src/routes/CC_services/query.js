const path = require("path")
const {getCCP} = require("../CA_services/buildCCP")
const {buildWallet} = require("../CA_services/AppUtils");
const {Gateway, Wallets} =  require("fabric-network");


const walletPath = "/usr/src/app/wallet"

exports.getAllProduce = async (request) => {
    let org = request.org;
    let data = request.data;

    const cpp = getCCP(org);
    const wallet = await buildWallet(Wallets, walletPath);
    const gateway = new Gateway();

    await gateway.connect(cpp, {
        wallet,
        identity: request.userId,
        discovery: {
            enabled: true,
            asLocalhost: false
        }
    });

    // Build a network instance based on the channel where the smart contract is deployed
    const network = await gateway.getNetwork(request.channelName);

    // Get the contract from the network.
    const contract = network.getContract(request.chaincodeName)
    let result = await contract.evaluateTransaction('GetAllProduce');
    return JSON.parse(result);
}

exports.getProduceHistory = async (request) => {
    let org = request.org;
    let data = request.data;

    const cpp = getCCP(org);
    const wallet = await buildWallet(Wallets, walletPath);
    const gateway = new Gateway();

    await gateway.connect(cpp, {
        wallet,
        identity: request.userId,
        discovery: {
            enabled: true,
            asLocalhost: false
        }
    });

    // Build a network instance based on the channel where the smart contract is deployed
    const network = await gateway.getNetwork(request.channelName);

    // Get the contract from the network.
    const contract = network.getContract(request.chaincodeName)
    let result = await contract.evaluateTransaction('GetProduceHistory',data.ProdID);
    return JSON.parse(result);
}
