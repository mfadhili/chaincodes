set -x

mkdir -p /organizations/peerOrganizations/retailer.agrinet.com/

export FABRIC_CA_CLIENT_HOME=/organizations/peerOrganizations/retailer.agrinet.com/



fabric-ca-client enroll -u https://admin:adminpw@ca-retailer:9054 --caname ca-retailer --tls.certfiles "/organizations/fabric-ca/retailer/tls-cert.pem"



echo 'NodeOUs:
  Enable: true
  ClientOUIdentifier:
    Certificate: cacerts/ca-retailer-9054-ca-retailer.pem
    OrganizationalUnitIdentifier: client
  PeerOUIdentifier:
    Certificate: cacerts/ca-retailer-9054-ca-retailer.pem
    OrganizationalUnitIdentifier: peer
  AdminOUIdentifier:
    Certificate: cacerts/ca-retailer-9054-ca-retailer.pem
    OrganizationalUnitIdentifier: admin
  OrdererOUIdentifier:
    Certificate: cacerts/ca-retailer-9054-ca-retailer.pem
    OrganizationalUnitIdentifier: orderer' > "/organizations/peerOrganizations/retailer.agrinet.com/msp/config.yaml"



fabric-ca-client register --caname ca-retailer --id.name peer0 --id.secret peer0pw --id.type peer --tls.certfiles "/organizations/fabric-ca/retailer/tls-cert.pem"



fabric-ca-client register --caname ca-retailer --id.name user1 --id.secret user1pw --id.type client --tls.certfiles "/organizations/fabric-ca/retailer/tls-cert.pem"




fabric-ca-client register --caname ca-retailer --id.name retaileradmin --id.secret retaileradminpw --id.type admin --tls.certfiles "/organizations/fabric-ca/retailer/tls-cert.pem"



fabric-ca-client enroll -u https://peer0:peer0pw@ca-retailer:9054 --caname ca-retailer -M "/organizations/peerOrganizations/retailer.agrinet.com/peers/peer0.retailer.agrinet.com/msp" --csr.hosts peer0.retailer.agrinet.com --csr.hosts  peer0-retailer --tls.certfiles "/organizations/fabric-ca/retailer/tls-cert.pem"



cp "/organizations/peerOrganizations/retailer.agrinet.com/msp/config.yaml" "/organizations/peerOrganizations/retailer.agrinet.com/peers/peer0.retailer.agrinet.com/msp/config.yaml"



fabric-ca-client enroll -u https://peer0:peer0pw@ca-retailer:9054 --caname ca-retailer -M "/organizations/peerOrganizations/retailer.agrinet.com/peers/peer0.retailer.agrinet.com/tls" --enrollment.profile tls --csr.hosts peer0.retailer.agrinet.com --csr.hosts  peer0-retailer --csr.hosts ca-retailer --csr.hosts localhost --tls.certfiles "/organizations/fabric-ca/retailer/tls-cert.pem"




cp "/organizations/peerOrganizations/retailer.agrinet.com/peers/peer0.retailer.agrinet.com/tls/tlscacerts/"* "/organizations/peerOrganizations/retailer.agrinet.com/peers/peer0.retailer.agrinet.com/tls/ca.crt"
cp "/organizations/peerOrganizations/retailer.agrinet.com/peers/peer0.retailer.agrinet.com/tls/signcerts/"* "/organizations/peerOrganizations/retailer.agrinet.com/peers/peer0.retailer.agrinet.com/tls/server.crt"
cp "/organizations/peerOrganizations/retailer.agrinet.com/peers/peer0.retailer.agrinet.com/tls/keystore/"* "/organizations/peerOrganizations/retailer.agrinet.com/peers/peer0.retailer.agrinet.com/tls/server.key"

mkdir -p "/organizations/peerOrganizations/retailer.agrinet.com/msp/tlscacerts"
cp "/organizations/peerOrganizations/retailer.agrinet.com/peers/peer0.retailer.agrinet.com/tls/tlscacerts/"* "/organizations/peerOrganizations/retailer.agrinet.com/msp/tlscacerts/ca.crt"

mkdir -p "/organizations/peerOrganizations/retailer.agrinet.com/tlsca"
cp "/organizations/peerOrganizations/retailer.agrinet.com/peers/peer0.retailer.agrinet.com/tls/tlscacerts/"* "/organizations/peerOrganizations/retailer.agrinet.com/tlsca/tlsca.retailer.agrinet.com-cert.pem"

mkdir -p "/organizations/peerOrganizations/retailer.agrinet.com/ca"
cp "/organizations/peerOrganizations/retailer.agrinet.com/peers/peer0.retailer.agrinet.com/msp/cacerts/"* "/organizations/peerOrganizations/retailer.agrinet.com/ca/ca.retailer.agrinet.com-cert.pem"


fabric-ca-client enroll -u https://user1:user1pw@ca-retailer:9054 --caname ca-retailer -M "/organizations/peerOrganizations/retailer.agrinet.com/users/User1@retailer.agrinet.com/msp" --tls.certfiles "/organizations/fabric-ca/retailer/tls-cert.pem"

cp "/organizations/peerOrganizations/retailer.agrinet.com/msp/config.yaml" "/organizations/peerOrganizations/retailer.agrinet.com/users/User1@retailer.agrinet.com/msp/config.yaml"

fabric-ca-client enroll -u https://retaileradmin:retaileradminpw@ca-retailer:9054 --caname ca-retailer -M "/organizations/peerOrganizations/retailer.agrinet.com/users/Admin@retailer.agrinet.com/msp" --tls.certfiles "/organizations/fabric-ca/retailer/tls-cert.pem"

cp "/organizations/peerOrganizations/retailer.agrinet.com/msp/config.yaml" "/organizations/peerOrganizations/retailer.agrinet.com/users/Admin@retailer.agrinet.com/msp/config.yaml"

{ set +x; } 2>/dev/null
