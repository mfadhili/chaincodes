

const {Utils:utils} = require("fabric-common")

const path = require('path')
const {getCCP} = require("./buildCCP");
const {buildCAClient, registerAndEnrollUser, enrollAdmin, userExist} = require("./CAUtil");
const FabricCAServices = require("fabric-ca-client");
const {getHostname} = require("./hostName");
const {buildWallet} = require("./AppUtils");
const {Wallets} = require("fabric-network");

// Is this used anywhere? Yup its used
let config = utils.getConfig()
config.file("/usr/src/app/config.json")

let walletPath;
/*
* Function to register a User
* Steps involve
*   - Getting the connection profile
*   - building the CAClient
*   - building a wallet
*   - enroll the admin
*   - registering and enrolling the user
* */
exports.registerUser = async ({OrgMSP, userID}) => {

    walletPath = "/usr/src/app/wallet"

    let cpp = getCCP(OrgMSP)
    let hostname = getHostname(OrgMSP)
    const caClient = buildCAClient(FabricCAServices, cpp,`ca-${hostname}`)

    // Build wallet
    const wallet = await buildWallet(Wallets,walletPath)
    console.log("wallet", wallet)

    await enrollAdmin(caClient,wallet,OrgMSP)

    await registerAndEnrollUser(caClient,wallet,OrgMSP,userID,`${hostname}.harvesting`)

    return {
        wallet
    }
}

exports.userExists = async ({OrgMSP, userId}) =>{
    let cpp = getCCP(OrgMSP)
    let hostname = getHostname(OrgMSP)

    const caClient = buildCAClient(FabricCAServices, cpp,`ca-${hostname}`)
    const wallet = buildWallet(Wallets,walletPath)

    return await userExist(wallet, userId)

}




