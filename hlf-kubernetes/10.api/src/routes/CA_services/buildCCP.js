const { buildCCPFarmer, buildCCPProcessor, buildCCPDistributor, buildCCPMiddleman, buildCCPRegulator, buildCCPStorage, buildCCPRetailer} = require("./AppUtils");

exports.getCCP = (org) => {
    let ccp;
    switch (org) {
        case "FarmerMSP":
            ccp = buildCCPFarmer();
            break;
        case "MiddlemanMSP":
            ccp = buildCCPMiddleman();
            break;
        case "ProcessorMSP":
            ccp = buildCCPProcessor();
            break;
        case "DistributorMSP":
            ccp = buildCCPDistributor();
            break;
        case "StorageMSP":
            ccp = buildCCPStorage();
            break;
        case "RegulatorMSP":
            ccp = buildCCPRegulator();
            break;
        case "RetailerMSP":
            ccp = buildCCPRetailer();
            break;
    }
    return ccp;
}