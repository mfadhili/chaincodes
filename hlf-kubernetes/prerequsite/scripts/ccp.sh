#!/bin/bash

function one_line_pem {
    echo "`awk 'NF {sub(/\\n/, ""); printf "%s\\\\\\\n",$0;}' $1`"
}

function json_ccp {
    local PP=$(one_line_pem $4)
    local CP=$(one_line_pem $5)
    sed -e "s/\${ORG}/$1/" \
        -e "s/\${ORGG}/$6/" \
        -e "s/\${P0PORT}/$2/" \
        -e "s/\${CAPORT}/$3/" \
        -e "s#\${PEERPEM}#$PP#" \
        -e "s#\${CAPEM}#$CP#" \
        connection-profile/ccp-template.json
}

function yaml_ccp {
    local PP=$(one_line_pem $4)
    local CP=$(one_line_pem $5)
    sed -e "s/\${ORG}/$1/" \
        -e "s/\${ORGG}/$6/" \
        -e "s/\${P0PORT}/$2/" \
        -e "s/\${CAPORT}/$3/" \
        -e "s#\${PEERPEM}#$PP#" \
        -e "s#\${CAPEM}#$CP#" \
        connection-profile/ccp-template.yaml | sed -e $'s/\\\\n/\\\n          /g'
}

ORG=farmer
ORGG=Farmer
P0PORT=7051
CAPORT=4054
PEERPEM=organizations/peerOrganizations/farmer.agrinet.com/tlsca/tlsca.farmer.agrinet.com-cert.pem
CAPEM=organizations/peerOrganizations/farmer.agrinet.com/ca/ca.farmer.agrinet.com-cert.pem

echo "$(json_ccp $ORG $P0PORT $CAPORT $PEERPEM $CAPEM $ORGG)" > connection-profile/connection-farmer.json
echo "$(yaml_ccp $ORG $P0PORT $CAPORT $PEERPEM $CAPEM $ORGG)" > connection-profile/connection-farmer.yaml

ORG=middleman
ORGG=Middleman
P0PORT=7051
CAPORT=3054
PEERPEM=organizations/peerOrganizations/middleman.agrinet.com/tlsca/tlsca.middleman.agrinet.com-cert.pem
CAPEM=organizations/peerOrganizations/middleman.agrinet.com/ca/ca.middleman.agrinet.com-cert.pem

echo "$(json_ccp $ORG $P0PORT $CAPORT $PEERPEM $CAPEM $ORGG)" > connection-profile/connection-middleman.json
echo "$(yaml_ccp $ORG $P0PORT $CAPORT $PEERPEM $CAPEM $ORGG)" > connection-profile/connection-middleman.yaml

ORG=distributor
ORGG=Distributor
P0PORT=7051
CAPORT=5054
PEERPEM=organizations/peerOrganizations/distributor.agrinet.com/tlsca/tlsca.distributor.agrinet.com-cert.pem
CAPEM=organizations/peerOrganizations/distributor.agrinet.com/ca/ca.distributor.agrinet.com-cert.pem

echo "$(json_ccp $ORG $P0PORT $CAPORT $PEERPEM $CAPEM $ORGG)" > connection-profile/connection-distributor.json
echo "$(yaml_ccp $ORG $P0PORT $CAPORT $PEERPEM $CAPEM $ORGG)" > connection-profile/connection-distributor.yaml

ORG=processor
ORGG=Processor
P0PORT=7051
CAPORT=6054
PEERPEM=organizations/peerOrganizations/processor.agrinet.com/tlsca/tlsca.processor.agrinet.com-cert.pem
CAPEM=organizations/peerOrganizations/processor.agrinet.com/ca/ca.processor.agrinet.com-cert.pem

echo "$(json_ccp $ORG $P0PORT $CAPORT $PEERPEM $CAPEM $ORGG)" > connection-profile/connection-processor.json
echo "$(yaml_ccp $ORG $P0PORT $CAPORT $PEERPEM $CAPEM $ORGG)" > connection-profile/connection-processor.yaml

ORG=storage
ORGG=Storage
P0PORT=7051
CAPORT=7054
PEERPEM=organizations/peerOrganizations/storage.agrinet.com/tlsca/tlsca.storage.agrinet.com-cert.pem
CAPEM=organizations/peerOrganizations/storage.agrinet.com/ca/ca.storage.agrinet.com-cert.pem

echo "$(json_ccp $ORG $P0PORT $CAPORT $PEERPEM $CAPEM $ORGG)" > connection-profile/connection-storage.json
echo "$(yaml_ccp $ORG $P0PORT $CAPORT $PEERPEM $CAPEM $ORGG)" > connection-profile/connection-storage.yaml

ORG=regulator
ORGG=Regulator
P0PORT=7051
CAPORT=8054
PEERPEM=organizations/peerOrganizations/regulator.agrinet.com/tlsca/tlsca.regulator.agrinet.com-cert.pem
CAPEM=organizations/peerOrganizations/regulator.agrinet.com/ca/ca.regulator.agrinet.com-cert.pem

echo "$(json_ccp $ORG $P0PORT $CAPORT $PEERPEM $CAPEM $ORGG)" > connection-profile/connection-regulator.json
echo "$(yaml_ccp $ORG $P0PORT $CAPORT $PEERPEM $CAPEM $ORGG)" > connection-profile/connection-regulator.yaml


ORG=retailer
ORGG=Retailer
P0PORT=7051
CAPORT=9054
PEERPEM=organizations/peerOrganizations/retailer.agrinet.com/tlsca/tlsca.retailer.agrinet.com-cert.pem
CAPEM=organizations/peerOrganizations/retailer.agrinet.com/ca/ca.retailer.agrinet.com-cert.pem

echo "$(json_ccp $ORG $P0PORT $CAPORT $PEERPEM $CAPEM $ORGG)" > connection-profile/connection-retailer.json
echo "$(yaml_ccp $ORG $P0PORT $CAPORT $PEERPEM $CAPEM $ORGG)" > connection-profile/connection-retailer.yaml


