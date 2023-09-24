CHANNEL_NAME="$1"
DELAY="$2"
MAX_RETRY="$3"
VERBOSE="$4"
: ${CHANNEL_NAME:="mychannel"}
: ${DELAY:="3"}
: ${MAX_RETRY:="5"}
: ${VERBOSE:="true"}
FABRIC_CFG_PATH=${PWD}configtx


createChannelTx() {

	set -x
	configtxgen -profile SevenOrgsChannel -outputCreateChannelTx ./channel-artifacts/${CHANNEL_NAME}.tx -channelID $CHANNEL_NAME
	res=$?
	{ set +x; } 2>/dev/null
	if [ $res -ne 0 ]; then
		fatalln "Failed to generate channel configuration transaction..."
	fi

}

createAnchorPeerTx() {

	for orgmsp in FarmerMSP MiddlemanMSP ProcessorMSP StorageMSP DistributorMSP RegulatorMSP RetailerMSP; do

	echo "Generating anchor peer update transaction for ${orgmsp}"
	set -x
	configtxgen -profile SevenOrgsChannel -outputAnchorPeersUpdate ./channel-artifacts/${orgmsp}anchors.tx -channelID $CHANNEL_NAME -asOrg ${orgmsp}
	res=$?
	{ set +x; } 2>/dev/null
	if [ $res -ne 0 ]; then
		fatalln "Failed to generate anchor peer update transaction for ${orgmsp}..."
	fi
	done
}



verifyResult() {
  if [ $1 -ne 0 ]; then
    fatalln "$2"
  fi
}



## Create channeltx
echo "Generating channel create transaction '${CHANNEL_NAME}.tx'"
createChannelTx

## Create anchorpeertx
echo "Generating anchor peer update transactions"
createAnchorPeerTx

exit 0