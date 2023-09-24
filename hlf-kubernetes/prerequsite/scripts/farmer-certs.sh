set -x

mkdir -p /organizations/peerOrganizations/farmer.agrinet.com/

export FABRIC_CA_CLIENT_HOME=/organizations/peerOrganizations/farmer.agrinet.com/



fabric-ca-client enroll -u https://admin:adminpw@ca-farmer:4054 --caname ca-farmer --tls.certfiles "/organizations/fabric-ca/farmer/tls-cert.pem"



echo 'NodeOUs:
  Enable: true
  ClientOUIdentifier:
    Certificate: cacerts/ca-farmer-4054-ca-farmer.pem
    OrganizationalUnitIdentifier: client
  PeerOUIdentifier:
    Certificate: cacerts/ca-farmer-4054-ca-farmer.pem
    OrganizationalUnitIdentifier: peer
  AdminOUIdentifier:
    Certificate: cacerts/ca-farmer-4054-ca-farmer.pem
    OrganizationalUnitIdentifier: admin
  OrdererOUIdentifier:
    Certificate: cacerts/ca-farmer-4054-ca-farmer.pem
    OrganizationalUnitIdentifier: orderer' > "/organizations/peerOrganizations/farmer.agrinet.com/msp/config.yaml"



fabric-ca-client register --caname ca-farmer --id.name peer0 --id.secret peer0pw --id.type peer --tls.certfiles "/organizations/fabric-ca/farmer/tls-cert.pem"



fabric-ca-client register --caname ca-farmer --id.name user1 --id.secret user1pw --id.type client --tls.certfiles "/organizations/fabric-ca/farmer/tls-cert.pem"




fabric-ca-client register --caname ca-farmer --id.name farmeradmin --id.secret farmeradminpw --id.type admin --tls.certfiles "/organizations/fabric-ca/farmer/tls-cert.pem"



fabric-ca-client enroll -u https://peer0:peer0pw@ca-farmer:4054 --caname ca-farmer -M "/organizations/peerOrganizations/farmer.agrinet.com/peers/peer0.farmer.agrinet.com/msp" --csr.hosts peer0.farmer.agrinet.com --csr.hosts  peer0-farmer --tls.certfiles "/organizations/fabric-ca/farmer/tls-cert.pem"



cp "/organizations/peerOrganizations/farmer.agrinet.com/msp/config.yaml" "/organizations/peerOrganizations/farmer.agrinet.com/peers/peer0.farmer.agrinet.com/msp/config.yaml"



fabric-ca-client enroll -u https://peer0:peer0pw@ca-farmer:4054 --caname ca-farmer -M "/organizations/peerOrganizations/farmer.agrinet.com/peers/peer0.farmer.agrinet.com/tls" --enrollment.profile tls --csr.hosts peer0.farmer.agrinet.com --csr.hosts  peer0-farmer --csr.hosts ca-farmer --csr.hosts localhost --tls.certfiles "/organizations/fabric-ca/farmer/tls-cert.pem"




cp "/organizations/peerOrganizations/farmer.agrinet.com/peers/peer0.farmer.agrinet.com/tls/tlscacerts/"* "/organizations/peerOrganizations/farmer.agrinet.com/peers/peer0.farmer.agrinet.com/tls/ca.crt"
cp "/organizations/peerOrganizations/farmer.agrinet.com/peers/peer0.farmer.agrinet.com/tls/signcerts/"* "/organizations/peerOrganizations/farmer.agrinet.com/peers/peer0.farmer.agrinet.com/tls/server.crt"
cp "/organizations/peerOrganizations/farmer.agrinet.com/peers/peer0.farmer.agrinet.com/tls/keystore/"* "/organizations/peerOrganizations/farmer.agrinet.com/peers/peer0.farmer.agrinet.com/tls/server.key"

mkdir -p "/organizations/peerOrganizations/farmer.agrinet.com/msp/tlscacerts"
cp "/organizations/peerOrganizations/farmer.agrinet.com/peers/peer0.farmer.agrinet.com/tls/tlscacerts/"* "/organizations/peerOrganizations/farmer.agrinet.com/msp/tlscacerts/ca.crt"

mkdir -p "/organizations/peerOrganizations/farmer.agrinet.com/tlsca"
cp "/organizations/peerOrganizations/farmer.agrinet.com/peers/peer0.farmer.agrinet.com/tls/tlscacerts/"* "/organizations/peerOrganizations/farmer.agrinet.com/tlsca/tlsca.farmer.agrinet.com-cert.pem"

mkdir -p "/organizations/peerOrganizations/farmer.agrinet.com/ca"
cp "/organizations/peerOrganizations/farmer.agrinet.com/peers/peer0.farmer.agrinet.com/msp/cacerts/"* "/organizations/peerOrganizations/farmer.agrinet.com/ca/ca.farmer.agrinet.com-cert.pem"


fabric-ca-client enroll -u https://user1:user1pw@ca-farmer:4054 --caname ca-farmer -M "/organizations/peerOrganizations/farmer.agrinet.com/users/User1@farmer.agrinet.com/msp" --tls.certfiles "/organizations/fabric-ca/farmer/tls-cert.pem"

cp "/organizations/peerOrganizations/farmer.agrinet.com/msp/config.yaml" "/organizations/peerOrganizations/farmer.agrinet.com/users/User1@farmer.agrinet.com/msp/config.yaml"

fabric-ca-client enroll -u https://farmeradmin:farmeradminpw@ca-farmer:4054 --caname ca-farmer -M "/organizations/peerOrganizations/farmer.agrinet.com/users/Admin@farmer.agrinet.com/msp" --tls.certfiles "/organizations/fabric-ca/farmer/tls-cert.pem"

cp "/organizations/peerOrganizations/farmer.agrinet.com/msp/config.yaml" "/organizations/peerOrganizations/farmer.agrinet.com/users/Admin@farmer.agrinet.com/msp/config.yaml"

{ set +x; } 2>/dev/null
