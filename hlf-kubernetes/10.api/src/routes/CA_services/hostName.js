
exports.getHostname = (org) => {
    let hostname;
    switch (org) {
        case "FarmerMSP":
            hostname = "farmer";
            break;
        case "MiddlemanMSP":
            hostname = "middleman";
            break;
        case "ProcessorMSP":
            hostname = "processor";
            break;
        case "DistributorMSP":
            hostname = "distributor";
            break;
        case "StorageMSP":
            hostname = "storage";
            break;
        case "RegulatorMSP":
            hostname = "regulator";
            break;
        case "RetailerMSP":
            hostname = "retailer";
            break;
    }
    return hostname;
}