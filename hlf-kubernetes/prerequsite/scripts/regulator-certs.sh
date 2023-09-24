set -x

mkdir -p /organizations/peerOrganizations/regulator.agrinet.com/

export FABRIC_CA_CLIENT_HOME=/organizations/peerOrganizations/regulator.agrinet.com/



fabric-ca-client enroll -u https://admin:adminpw@ca-regulator:8054 --caname ca-regulator --tls.certfiles "/organizations/fabric-ca/regulator/tls-cert.pem"



echo 'NodeOUs:
  Enable: true
  ClientOUIdentifier:
    Certificate: cacerts/ca-regulator-8054-ca-regulator.pem
    OrganizationalUnitIdentifier: client
  PeerOUIdentifier:
    Certificate: cacerts/ca-regulator-8054-ca-regulator.pem
    OrganizationalUnitIdentifier: peer
  AdminOUIdentifier:
    Certificate: cacerts/ca-regulator-8054-ca-regulator.pem
    OrganizationalUnitIdentifier: admin
  OrdererOUIdentifier:
    Certificate: cacerts/ca-regulator-8054-ca-regulator.pem
    OrganizationalUnitIdentifier: orderer' > "/organizations/peerOrganizations/regulator.agrinet.com/msp/config.yaml"



fabric-ca-client register --caname ca-regulator --id.name peer0 --id.secret peer0pw --id.type peer --tls.certfiles "/organizations/fabric-ca/regulator/tls-cert.pem"



fabric-ca-client register --caname ca-regulator --id.name user1 --id.secret user1pw --id.type client --tls.certfiles "/organizations/fabric-ca/regulator/tls-cert.pem"




fabric-ca-client register --caname ca-regulator --id.name regulatoradmin --id.secret regulatoradminpw --id.type admin --tls.certfiles "/organizations/fabric-ca/regulator/tls-cert.pem"



fabric-ca-client enroll -u https://peer0:peer0pw@ca-regulator:8054 --caname ca-regulator -M "/organizations/peerOrganizations/regulator.agrinet.com/peers/peer0.regulator.agrinet.com/msp" --csr.hosts peer0.regulator.agrinet.com --csr.hosts  peer0-regulator --tls.certfiles "/organizations/fabric-ca/regulator/tls-cert.pem"



cp "/organizations/peerOrganizations/regulator.agrinet.com/msp/config.yaml" "/organizations/peerOrganizations/regulator.agrinet.com/peers/peer0.regulator.agrinet.com/msp/config.yaml"



fabric-ca-client enroll -u https://peer0:peer0pw@ca-regulator:8054 --caname ca-regulator -M "/organizations/peerOrganizations/regulator.agrinet.com/peers/peer0.regulator.agrinet.com/tls" --enrollment.profile tls --csr.hosts peer0.regulator.agrinet.com --csr.hosts  peer0-regulator --csr.hosts ca-regulator --csr.hosts localhost --tls.certfiles "/organizations/fabric-ca/regulator/tls-cert.pem"




cp "/organizations/peerOrganizations/regulator.agrinet.com/peers/peer0.regulator.agrinet.com/tls/tlscacerts/"* "/organizations/peerOrganizations/regulator.agrinet.com/peers/peer0.regulator.agrinet.com/tls/ca.crt"
cp "/organizations/peerOrganizations/regulator.agrinet.com/peers/peer0.regulator.agrinet.com/tls/signcerts/"* "/organizations/peerOrganizations/regulator.agrinet.com/peers/peer0.regulator.agrinet.com/tls/server.crt"
cp "/organizations/peerOrganizations/regulator.agrinet.com/peers/peer0.regulator.agrinet.com/tls/keystore/"* "/organizations/peerOrganizations/regulator.agrinet.com/peers/peer0.regulator.agrinet.com/tls/server.key"

mkdir -p "/organizations/peerOrganizations/regulator.agrinet.com/msp/tlscacerts"
cp "/organizations/peerOrganizations/regulator.agrinet.com/peers/peer0.regulator.agrinet.com/tls/tlscacerts/"* "/organizations/peerOrganizations/regulator.agrinet.com/msp/tlscacerts/ca.crt"

mkdir -p "/organizations/peerOrganizations/regulator.agrinet.com/tlsca"
cp "/organizations/peerOrganizations/regulator.agrinet.com/peers/peer0.regulator.agrinet.com/tls/tlscacerts/"* "/organizations/peerOrganizations/regulator.agrinet.com/tlsca/tlsca.regulator.agrinet.com-cert.pem"

mkdir -p "/organizations/peerOrganizations/regulator.agrinet.com/ca"
cp "/organizations/peerOrganizations/regulator.agrinet.com/peers/peer0.regulator.agrinet.com/msp/cacerts/"* "/organizations/peerOrganizations/regulator.agrinet.com/ca/ca.regulator.agrinet.com-cert.pem"


fabric-ca-client enroll -u https://user1:user1pw@ca-regulator:8054 --caname ca-regulator -M "/organizations/peerOrganizations/regulator.agrinet.com/users/User1@regulator.agrinet.com/msp" --tls.certfiles "/organizations/fabric-ca/regulator/tls-cert.pem"

cp "/organizations/peerOrganizations/regulator.agrinet.com/msp/config.yaml" "/organizations/peerOrganizations/regulator.agrinet.com/users/User1@regulator.agrinet.com/msp/config.yaml"

fabric-ca-client enroll -u https://regulatoradmin:regulatoradminpw@ca-regulator:8054 --caname ca-regulator -M "/organizations/peerOrganizations/regulator.agrinet.com/users/Admin@regulator.agrinet.com/msp" --tls.certfiles "/organizations/fabric-ca/regulator/tls-cert.pem"

cp "/organizations/peerOrganizations/regulator.agrinet.com/msp/config.yaml" "/organizations/peerOrganizations/regulator.agrinet.com/users/Admin@regulator.agrinet.com/msp/config.yaml"

{ set +x; } 2>/dev/null
