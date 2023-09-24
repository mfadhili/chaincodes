set -x

mkdir -p /organizations/peerOrganizations/processor.agrinet.com/

export FABRIC_CA_CLIENT_HOME=/organizations/peerOrganizations/processor.agrinet.com/



fabric-ca-client enroll -u https://admin:adminpw@ca-processor:6054 --caname ca-processor --tls.certfiles "/organizations/fabric-ca/processor/tls-cert.pem"



echo 'NodeOUs:
  Enable: true
  ClientOUIdentifier:
    Certificate: cacerts/ca-processor-6054-ca-processor.pem
    OrganizationalUnitIdentifier: client
  PeerOUIdentifier:
    Certificate: cacerts/ca-processor-6054-ca-processor.pem
    OrganizationalUnitIdentifier: peer
  AdminOUIdentifier:
    Certificate: cacerts/ca-processor-6054-ca-processor.pem
    OrganizationalUnitIdentifier: admin
  OrdererOUIdentifier:
    Certificate: cacerts/ca-processor-6054-ca-processor.pem
    OrganizationalUnitIdentifier: orderer' > "/organizations/peerOrganizations/processor.agrinet.com/msp/config.yaml"



fabric-ca-client register --caname ca-processor --id.name peer0 --id.secret peer0pw --id.type peer --tls.certfiles "/organizations/fabric-ca/processor/tls-cert.pem"



fabric-ca-client register --caname ca-processor --id.name user1 --id.secret user1pw --id.type client --tls.certfiles "/organizations/fabric-ca/processor/tls-cert.pem"




fabric-ca-client register --caname ca-processor --id.name processoradmin --id.secret processoradminpw --id.type admin --tls.certfiles "/organizations/fabric-ca/processor/tls-cert.pem"



fabric-ca-client enroll -u https://peer0:peer0pw@ca-processor:6054 --caname ca-processor -M "/organizations/peerOrganizations/processor.agrinet.com/peers/peer0.processor.agrinet.com/msp" --csr.hosts peer0.processor.agrinet.com --csr.hosts  peer0-processor --tls.certfiles "/organizations/fabric-ca/processor/tls-cert.pem"



cp "/organizations/peerOrganizations/processor.agrinet.com/msp/config.yaml" "/organizations/peerOrganizations/processor.agrinet.com/peers/peer0.processor.agrinet.com/msp/config.yaml"



fabric-ca-client enroll -u https://peer0:peer0pw@ca-processor:6054 --caname ca-processor -M "/organizations/peerOrganizations/processor.agrinet.com/peers/peer0.processor.agrinet.com/tls" --enrollment.profile tls --csr.hosts peer0.processor.agrinet.com --csr.hosts  peer0-processor --csr.hosts ca-processor --csr.hosts localhost --tls.certfiles "/organizations/fabric-ca/processor/tls-cert.pem"




cp "/organizations/peerOrganizations/processor.agrinet.com/peers/peer0.processor.agrinet.com/tls/tlscacerts/"* "/organizations/peerOrganizations/processor.agrinet.com/peers/peer0.processor.agrinet.com/tls/ca.crt"
cp "/organizations/peerOrganizations/processor.agrinet.com/peers/peer0.processor.agrinet.com/tls/signcerts/"* "/organizations/peerOrganizations/processor.agrinet.com/peers/peer0.processor.agrinet.com/tls/server.crt"
cp "/organizations/peerOrganizations/processor.agrinet.com/peers/peer0.processor.agrinet.com/tls/keystore/"* "/organizations/peerOrganizations/processor.agrinet.com/peers/peer0.processor.agrinet.com/tls/server.key"

mkdir -p "/organizations/peerOrganizations/processor.agrinet.com/msp/tlscacerts"
cp "/organizations/peerOrganizations/processor.agrinet.com/peers/peer0.processor.agrinet.com/tls/tlscacerts/"* "/organizations/peerOrganizations/processor.agrinet.com/msp/tlscacerts/ca.crt"

mkdir -p "/organizations/peerOrganizations/processor.agrinet.com/tlsca"
cp "/organizations/peerOrganizations/processor.agrinet.com/peers/peer0.processor.agrinet.com/tls/tlscacerts/"* "/organizations/peerOrganizations/processor.agrinet.com/tlsca/tlsca.processor.agrinet.com-cert.pem"

mkdir -p "/organizations/peerOrganizations/processor.agrinet.com/ca"
cp "/organizations/peerOrganizations/processor.agrinet.com/peers/peer0.processor.agrinet.com/msp/cacerts/"* "/organizations/peerOrganizations/processor.agrinet.com/ca/ca.processor.agrinet.com-cert.pem"


fabric-ca-client enroll -u https://user1:user1pw@ca-processor:6054 --caname ca-processor -M "/organizations/peerOrganizations/processor.agrinet.com/users/User1@processor.agrinet.com/msp" --tls.certfiles "/organizations/fabric-ca/processor/tls-cert.pem"

cp "/organizations/peerOrganizations/processor.agrinet.com/msp/config.yaml" "/organizations/peerOrganizations/processor.agrinet.com/users/User1@processor.agrinet.com/msp/config.yaml"

fabric-ca-client enroll -u https://processoradmin:processoradminpw@ca-processor:6054 --caname ca-processor -M "/organizations/peerOrganizations/processor.agrinet.com/users/Admin@processor.agrinet.com/msp" --tls.certfiles "/organizations/fabric-ca/processor/tls-cert.pem"

cp "/organizations/peerOrganizations/processor.agrinet.com/msp/config.yaml" "/organizations/peerOrganizations/processor.agrinet.com/users/Admin@processor.agrinet.com/msp/config.yaml"

{ set +x; } 2>/dev/null
