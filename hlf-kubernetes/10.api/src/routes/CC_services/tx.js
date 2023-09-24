const path = require("path");
const {getCCP} = require("../CA_services/buildCCP");
const {buildWallet} = require("../CA_services/AppUtils");
const {Wallets, Gateway} = require("fabric-network");


const walletPath = "/usr/src/app/wallet"
let wallet

/**
 * request body
 * {
 *     org:Org1MSP,
 *     channelName:"mychannel",
 *     chaincodeName:"basic",
 *     userId:"aditya"
 *     data:{
 *     id:"asset1",
 *     color:"red",
 *     size:5,
 *     appraisedValue:200,
 *     owner:"TOM"
 * }
 *
 * */

exports.createProduce = async (request) =>{
    let org = request.org;
    let data1 = request.data;

    const cpp = getCCP(org);
    const wallet = await buildWallet(Wallets, walletPath);
    const gateway = new Gateway();

    console.log(data1)

    await gateway.connect(cpp, {
        identity: request.userId,
        wallet,
        discovery: {
            enabled: true,
            asLocalhost: false
        }
    });

    // Build a network instance based on the channel where the smart contract is deployed
    const network = await gateway.getNetwork(request.channelName);
    console.log(network)
    // Get the contract from the network.
    const contract = network.getContract(request.chaincodeName)
    console.log(contract)
    //let result = await contract.evaluateTransaction('GetAllProduce')
   // let result = await contract.submitTransaction('CreateProduce',data1.ProdID,data1.FarmName,data1.FarmAddress,data1.FarmContact,data1.FarmLocation,data1.ProduceName,data1.ProduceType,data1.ProduceLotNo,data1.ProduceUnits,data1.ProduceQuantity,data1.HarvestDate,data1.IntermediaryName,data1.IntermediaryType,data1.IntermediaryAddress,data1.IntermediaryLocation,data1.Processes,data1.ProcesLotNo,data1.ProcessDate,data1.OtherInfo);
    let result = await contract.submitTransaction('CreateProduce',"P00020","Obed Farm","8065 Rocky River Lane Adrian, MI 49221","(256) 596-3619","71°39′N 128°52′E","Farmhouse Milk","Mursik","PL5356458","Liters","1000","2023-03-27","","","","","","","","");
    return (result);
}

exports.updateProduce = async (request) => {
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
    let result = await contract.submitTransaction('UpdateProduce',data.ProdID,data.FarmName,data.FarmAddress,data.FarmContact,data.FarmLocation,data.ProduceName,data.ProduceType,data.ProduceLotNo,data.ProduceUnits,data.ProduceQuantity,data.HarvestDate,data.IntermediaryName,data.IntermediaryType,data.IntermediaryAddress,data.IntermediaryLocation,data.Processes,data.ProcesLotNo,data.ProcessDate,data.OtherInfo);
    return (result);
}

exports.deleteProduce = async (request) => {
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
    let result = await contract.submitTransaction('DeleteProduce',data.ProdID);
    return (result);
}

exports.transferProduce = async (request) => {
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
    let result = await contract.submitTransaction('TransferProduce',data.ProdID,data.IntermediaryName,data.IntermediaryType,data.IntermediaryAddress,data.IntermediaryLocation,data.Processes,data.ProcesLotNo,data.ProcessDate,data.OtherInfo);
    return JSON.parse(result);
}