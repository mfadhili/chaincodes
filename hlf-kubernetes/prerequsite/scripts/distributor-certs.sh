set -x

mkdir -p /organizations/peerOrganizations/distributor.agrinet.com/

export FABRIC_CA_CLIENT_HOME=/organizations/peerOrganizations/distributor.agrinet.com/



fabric-ca-client enroll -u https://admin:adminpw@ca-distributor:5054 --caname ca-distributor --tls.certfiles "/organizations/fabric-ca/distributor/tls-cert.pem"



echo 'NodeOUs:
  Enable: true
  ClientOUIdentifier:
    Certificate: cacerts/ca-distributor-5054-ca-distributor.pem
    OrganizationalUnitIdentifier: client
  PeerOUIdentifier:
    Certificate: cacerts/ca-distributor-5054-ca-distributor.pem
    OrganizationalUnitIdentifier: peer
  AdminOUIdentifier:
    Certificate: cacerts/ca-distributor-5054-ca-distributor.pem
    OrganizationalUnitIdentifier: admin
  OrdererOUIdentifier:
    Certificate: cacerts/ca-distributor-5054-ca-distributor.pem
    OrganizationalUnitIdentifier: orderer' > "/organizations/peerOrganizations/distributor.agrinet.com/msp/config.yaml"



fabric-ca-client register --caname ca-distributor --id.name peer0 --id.secret peer0pw --id.type peer --tls.certfiles "/organizations/fabric-ca/distributor/tls-cert.pem"



fabric-ca-client register --caname ca-distributor --id.name user1 --id.secret user1pw --id.type client --tls.certfiles "/organizations/fabric-ca/distributor/tls-cert.pem"




fabric-ca-client register --caname ca-distributor --id.name distributoradmin --id.secret distributoradminpw --id.type admin --tls.certfiles "/organizations/fabric-ca/distributor/tls-cert.pem"



fabric-ca-client enroll -u https://peer0:peer0pw@ca-distributor:5054 --caname ca-distributor -M "/organizations/peerOrganizations/distributor.agrinet.com/peers/peer0.distributor.agrinet.com/msp" --csr.hosts peer0.distributor.agrinet.com --csr.hosts  peer0-distributor --tls.certfiles "/organizations/fabric-ca/distributor/tls-cert.pem"



cp "/organizations/peerOrganizations/distributor.agrinet.com/msp/config.yaml" "/organizations/peerOrganizations/distributor.agrinet.com/peers/peer0.distributor.agrinet.com/msp/config.yaml"



fabric-ca-client enroll -u https://peer0:peer0pw@ca-distributor:5054 --caname ca-distributor -M "/organizations/peerOrganizations/distributor.agrinet.com/peers/peer0.distributor.agrinet.com/tls" --enrollment.profile tls --csr.hosts peer0.distributor.agrinet.com --csr.hosts  peer0-distributor --csr.hosts ca-distributor --csr.hosts localhost --tls.certfiles "/organizations/fabric-ca/distributor/tls-cert.pem"




cp "/organizations/peerOrganizations/distributor.agrinet.com/peers/peer0.distributor.agrinet.com/tls/tlscacerts/"* "/organizations/peerOrganizations/distributor.agrinet.com/peers/peer0.distributor.agrinet.com/tls/ca.crt"
cp "/organizations/peerOrganizations/distributor.agrinet.com/peers/peer0.distributor.agrinet.com/tls/signcerts/"* "/organizations/peerOrganizations/distributor.agrinet.com/peers/peer0.distributor.agrinet.com/tls/server.crt"
cp "/organizations/peerOrganizations/distributor.agrinet.com/peers/peer0.distributor.agrinet.com/tls/keystore/"* "/organizations/peerOrganizations/distributor.agrinet.com/peers/peer0.distributor.agrinet.com/tls/server.key"

mkdir -p "/organizations/peerOrganizations/distributor.agrinet.com/msp/tlscacerts"
cp "/organizations/peerOrganizations/distributor.agrinet.com/peers/peer0.distributor.agrinet.com/tls/tlscacerts/"* "/organizations/peerOrganizations/distributor.agrinet.com/msp/tlscacerts/ca.crt"

mkdir -p "/organizations/peerOrganizations/distributor.agrinet.com/tlsca"
cp "/organizations/peerOrganizations/distributor.agrinet.com/peers/peer0.distributor.agrinet.com/tls/tlscacerts/"* "/organizations/peerOrganizations/distributor.agrinet.com/tlsca/tlsca.distributor.agrinet.com-cert.pem"

mkdir -p "/organizations/peerOrganizations/distributor.agrinet.com/ca"
cp "/organizations/peerOrganizations/distributor.agrinet.com/peers/peer0.distributor.agrinet.com/msp/cacerts/"* "/organizations/peerOrganizations/distributor.agrinet.com/ca/ca.distributor.agrinet.com-cert.pem"


fabric-ca-client enroll -u https://user1:user1pw@ca-distributor:5054 --caname ca-distributor -M "/organizations/peerOrganizations/distributor.agrinet.com/users/User1@distributor.agrinet.com/msp" --tls.certfiles "/organizations/fabric-ca/distributor/tls-cert.pem"

cp "/organizations/peerOrganizations/distributor.agrinet.com/msp/config.yaml" "/organizations/peerOrganizations/distributor.agrinet.com/users/User1@distributor.agrinet.com/msp/config.yaml"

fabric-ca-client enroll -u https://distributoradmin:distributoradminpw@ca-distributor:5054 --caname ca-distributor -M "/organizations/peerOrganizations/distributor.agrinet.com/users/Admin@distributor.agrinet.com/msp" --tls.certfiles "/organizations/fabric-ca/distributor/tls-cert.pem"

cp "/organizations/peerOrganizations/distributor.agrinet.com/msp/config.yaml" "/organizations/peerOrganizations/distributor.agrinet.com/users/Admin@distributor.agrinet.com/msp/config.yaml"

{ set +x; } 2>/dev/null
