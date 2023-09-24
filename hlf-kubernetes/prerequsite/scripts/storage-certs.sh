set -x

mkdir -p /organizations/peerOrganizations/storage.agrinet.com/

export FABRIC_CA_CLIENT_HOME=/organizations/peerOrganizations/storage.agrinet.com/



fabric-ca-client enroll -u https://admin:adminpw@ca-storage:7054 --caname ca-storage --tls.certfiles "/organizations/fabric-ca/storage/tls-cert.pem"



echo 'NodeOUs:
  Enable: true
  ClientOUIdentifier:
    Certificate: cacerts/ca-storage-7054-ca-storage.pem
    OrganizationalUnitIdentifier: client
  PeerOUIdentifier:
    Certificate: cacerts/ca-storage-7054-ca-storage.pem
    OrganizationalUnitIdentifier: peer
  AdminOUIdentifier:
    Certificate: cacerts/ca-storage-7054-ca-storage.pem
    OrganizationalUnitIdentifier: admin
  OrdererOUIdentifier:
    Certificate: cacerts/ca-storage-7054-ca-storage.pem
    OrganizationalUnitIdentifier: orderer' > "/organizations/peerOrganizations/storage.agrinet.com/msp/config.yaml"



fabric-ca-client register --caname ca-storage --id.name peer0 --id.secret peer0pw --id.type peer --tls.certfiles "/organizations/fabric-ca/storage/tls-cert.pem"



fabric-ca-client register --caname ca-storage --id.name user1 --id.secret user1pw --id.type client --tls.certfiles "/organizations/fabric-ca/storage/tls-cert.pem"




fabric-ca-client register --caname ca-storage --id.name storageadmin --id.secret storageadminpw --id.type admin --tls.certfiles "/organizations/fabric-ca/storage/tls-cert.pem"



fabric-ca-client enroll -u https://peer0:peer0pw@ca-storage:7054 --caname ca-storage -M "/organizations/peerOrganizations/storage.agrinet.com/peers/peer0.storage.agrinet.com/msp" --csr.hosts peer0.storage.agrinet.com --csr.hosts  peer0-storage --tls.certfiles "/organizations/fabric-ca/storage/tls-cert.pem"



cp "/organizations/peerOrganizations/storage.agrinet.com/msp/config.yaml" "/organizations/peerOrganizations/storage.agrinet.com/peers/peer0.storage.agrinet.com/msp/config.yaml"



fabric-ca-client enroll -u https://peer0:peer0pw@ca-storage:7054 --caname ca-storage -M "/organizations/peerOrganizations/storage.agrinet.com/peers/peer0.storage.agrinet.com/tls" --enrollment.profile tls --csr.hosts peer0.storage.agrinet.com --csr.hosts  peer0-storage --csr.hosts ca-storage --csr.hosts localhost --tls.certfiles "/organizations/fabric-ca/storage/tls-cert.pem"




cp "/organizations/peerOrganizations/storage.agrinet.com/peers/peer0.storage.agrinet.com/tls/tlscacerts/"* "/organizations/peerOrganizations/storage.agrinet.com/peers/peer0.storage.agrinet.com/tls/ca.crt"
cp "/organizations/peerOrganizations/storage.agrinet.com/peers/peer0.storage.agrinet.com/tls/signcerts/"* "/organizations/peerOrganizations/storage.agrinet.com/peers/peer0.storage.agrinet.com/tls/server.crt"
cp "/organizations/peerOrganizations/storage.agrinet.com/peers/peer0.storage.agrinet.com/tls/keystore/"* "/organizations/peerOrganizations/storage.agrinet.com/peers/peer0.storage.agrinet.com/tls/server.key"

mkdir -p "/organizations/peerOrganizations/storage.agrinet.com/msp/tlscacerts"
cp "/organizations/peerOrganizations/storage.agrinet.com/peers/peer0.storage.agrinet.com/tls/tlscacerts/"* "/organizations/peerOrganizations/storage.agrinet.com/msp/tlscacerts/ca.crt"

mkdir -p "/organizations/peerOrganizations/storage.agrinet.com/tlsca"
cp "/organizations/peerOrganizations/storage.agrinet.com/peers/peer0.storage.agrinet.com/tls/tlscacerts/"* "/organizations/peerOrganizations/storage.agrinet.com/tlsca/tlsca.storage.agrinet.com-cert.pem"

mkdir -p "/organizations/peerOrganizations/storage.agrinet.com/ca"
cp "/organizations/peerOrganizations/storage.agrinet.com/peers/peer0.storage.agrinet.com/msp/cacerts/"* "/organizations/peerOrganizations/storage.agrinet.com/ca/ca.storage.agrinet.com-cert.pem"


fabric-ca-client enroll -u https://user1:user1pw@ca-storage:7054 --caname ca-storage -M "/organizations/peerOrganizations/storage.agrinet.com/users/User1@storage.agrinet.com/msp" --tls.certfiles "/organizations/fabric-ca/storage/tls-cert.pem"

cp "/organizations/peerOrganizations/storage.agrinet.com/msp/config.yaml" "/organizations/peerOrganizations/storage.agrinet.com/users/User1@storage.agrinet.com/msp/config.yaml"

fabric-ca-client enroll -u https://storageadmin:storageadminpw@ca-storage:7054 --caname ca-storage -M "/organizations/peerOrganizations/storage.agrinet.com/users/Admin@storage.agrinet.com/msp" --tls.certfiles "/organizations/fabric-ca/storage/tls-cert.pem"

cp "/organizations/peerOrganizations/storage.agrinet.com/msp/config.yaml" "/organizations/peerOrganizations/storage.agrinet.com/users/Admin@storage.agrinet.com/msp/config.yaml"

{ set +x; } 2>/dev/null
