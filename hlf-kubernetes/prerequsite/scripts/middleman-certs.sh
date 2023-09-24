set -x

mkdir -p /organizations/peerOrganizations/middleman.agrinet.com/

export FABRIC_CA_CLIENT_HOME=/organizations/peerOrganizations/middleman.agrinet.com/



fabric-ca-client enroll -u https://admin:adminpw@ca-middleman:3054 --caname ca-middleman --tls.certfiles "/organizations/fabric-ca/middleman/tls-cert.pem"



echo 'NodeOUs:
  Enable: true
  ClientOUIdentifier:
    Certificate: cacerts/ca-middleman-3054-ca-middleman.pem
    OrganizationalUnitIdentifier: client
  PeerOUIdentifier:
    Certificate: cacerts/ca-middleman-3054-ca-middleman.pem
    OrganizationalUnitIdentifier: peer
  AdminOUIdentifier:
    Certificate: cacerts/ca-middleman-3054-ca-middleman.pem
    OrganizationalUnitIdentifier: admin
  OrdererOUIdentifier:
    Certificate: cacerts/ca-middleman-3054-ca-middleman.pem
    OrganizationalUnitIdentifier: orderer' > "/organizations/peerOrganizations/middleman.agrinet.com/msp/config.yaml"



fabric-ca-client register --caname ca-middleman --id.name peer0 --id.secret peer0pw --id.type peer --tls.certfiles "/organizations/fabric-ca/middleman/tls-cert.pem"



fabric-ca-client register --caname ca-middleman --id.name user1 --id.secret user1pw --id.type client --tls.certfiles "/organizations/fabric-ca/middleman/tls-cert.pem"




fabric-ca-client register --caname ca-middleman --id.name middlemanadmin --id.secret middlemanadminpw --id.type admin --tls.certfiles "/organizations/fabric-ca/middleman/tls-cert.pem"



fabric-ca-client enroll -u https://peer0:peer0pw@ca-middleman:3054 --caname ca-middleman -M "/organizations/peerOrganizations/middleman.agrinet.com/peers/peer0.middleman.agrinet.com/msp" --csr.hosts peer0.middleman.agrinet.com --csr.hosts  peer0-middleman --tls.certfiles "/organizations/fabric-ca/middleman/tls-cert.pem"



cp "/organizations/peerOrganizations/middleman.agrinet.com/msp/config.yaml" "/organizations/peerOrganizations/middleman.agrinet.com/peers/peer0.middleman.agrinet.com/msp/config.yaml"



fabric-ca-client enroll -u https://peer0:peer0pw@ca-middleman:3054 --caname ca-middleman -M "/organizations/peerOrganizations/middleman.agrinet.com/peers/peer0.middleman.agrinet.com/tls" --enrollment.profile tls --csr.hosts peer0.middleman.agrinet.com --csr.hosts  peer0-middleman --csr.hosts ca-middleman --csr.hosts localhost --tls.certfiles "/organizations/fabric-ca/middleman/tls-cert.pem"




cp "/organizations/peerOrganizations/middleman.agrinet.com/peers/peer0.middleman.agrinet.com/tls/tlscacerts/"* "/organizations/peerOrganizations/middleman.agrinet.com/peers/peer0.middleman.agrinet.com/tls/ca.crt"
cp "/organizations/peerOrganizations/middleman.agrinet.com/peers/peer0.middleman.agrinet.com/tls/signcerts/"* "/organizations/peerOrganizations/middleman.agrinet.com/peers/peer0.middleman.agrinet.com/tls/server.crt"
cp "/organizations/peerOrganizations/middleman.agrinet.com/peers/peer0.middleman.agrinet.com/tls/keystore/"* "/organizations/peerOrganizations/middleman.agrinet.com/peers/peer0.middleman.agrinet.com/tls/server.key"

mkdir -p "/organizations/peerOrganizations/middleman.agrinet.com/msp/tlscacerts"
cp "/organizations/peerOrganizations/middleman.agrinet.com/peers/peer0.middleman.agrinet.com/tls/tlscacerts/"* "/organizations/peerOrganizations/middleman.agrinet.com/msp/tlscacerts/ca.crt"

mkdir -p "/organizations/peerOrganizations/middleman.agrinet.com/tlsca"
cp "/organizations/peerOrganizations/middleman.agrinet.com/peers/peer0.middleman.agrinet.com/tls/tlscacerts/"* "/organizations/peerOrganizations/middleman.agrinet.com/tlsca/tlsca.middleman.agrinet.com-cert.pem"

mkdir -p "/organizations/peerOrganizations/middleman.agrinet.com/ca"
cp "/organizations/peerOrganizations/middleman.agrinet.com/peers/peer0.middleman.agrinet.com/msp/cacerts/"* "/organizations/peerOrganizations/middleman.agrinet.com/ca/ca.middleman.agrinet.com-cert.pem"


fabric-ca-client enroll -u https://user1:user1pw@ca-middleman:3054 --caname ca-middleman -M "/organizations/peerOrganizations/middleman.agrinet.com/users/User1@middleman.agrinet.com/msp" --tls.certfiles "/organizations/fabric-ca/middleman/tls-cert.pem"

cp "/organizations/peerOrganizations/middleman.agrinet.com/msp/config.yaml" "/organizations/peerOrganizations/middleman.agrinet.com/users/User1@middleman.agrinet.com/msp/config.yaml"

fabric-ca-client enroll -u https://middlemanadmin:middlemanadminpw@ca-middleman:3054 --caname ca-middleman -M "/organizations/peerOrganizations/middleman.agrinet.com/users/Admin@middleman.agrinet.com/msp" --tls.certfiles "/organizations/fabric-ca/middleman/tls-cert.pem"

cp "/organizations/peerOrganizations/middleman.agrinet.com/msp/config.yaml" "/organizations/peerOrganizations/middleman.agrinet.com/users/Admin@middleman.agrinet.com/msp/config.yaml"

{ set +x; } 2>/dev/null
