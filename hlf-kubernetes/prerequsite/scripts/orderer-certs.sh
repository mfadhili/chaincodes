
  sleep 2
  mkdir -p organizations/ordererOrganizations/agrinet.com

  export FABRIC_CA_CLIENT_HOME=/organizations/ordererOrganizations/agrinet.com
echo $FABRIC_CA_CLIENT_HOME

  set -x
  fabric-ca-client enroll -u https://admin:adminpw@ca-orderer:10054 --caname ca-orderer --tls.certfiles /organizations/fabric-ca/ordererOrg/tls-cert.pem
  { set +x; } 2>/dev/null

  echo 'NodeOUs:
  Enable: true
  ClientOUIdentifier:
    Certificate: cacerts/ca-orderer-10054-ca-orderer.pem
    OrganizationalUnitIdentifier: client
  PeerOUIdentifier:
    Certificate: cacerts/ca-orderer-10054-ca-orderer.pem
    OrganizationalUnitIdentifier: peer
  AdminOUIdentifier:
    Certificate: cacerts/ca-orderer-10054-ca-orderer.pem
    OrganizationalUnitIdentifier: admin
  OrdererOUIdentifier:
    Certificate: cacerts/ca-orderer-10054-ca-orderer.pem
    OrganizationalUnitIdentifier: orderer' >/organizations/ordererOrganizations/agrinet.com/msp/config.yaml

  echo "Register orderer"
  set -x
  fabric-ca-client register --caname ca-orderer --id.name orderer --id.secret ordererpw --id.type orderer --tls.certfiles /organizations/fabric-ca/ordererOrg/tls-cert.pem
  { set +x; } 2>/dev/null


  echo "Register orderer2"
  set -x
  fabric-ca-client register --caname ca-orderer --id.name orderer2 --id.secret ordererpw --id.type orderer --tls.certfiles  /organizations/fabric-ca/ordererOrg/tls-cert.pem
  { set +x; } 2>/dev/null

  echo "Register orderer3"
  set -x
  fabric-ca-client register --caname ca-orderer --id.name orderer3 --id.secret ordererpw --id.type orderer --tls.certfiles  /organizations/fabric-ca/ordererOrg/tls-cert.pem
  { set +x; } 2>/dev/null


  echo "Register orderer4"
  set -x
  fabric-ca-client register --caname ca-orderer --id.name orderer4 --id.secret ordererpw --id.type orderer --tls.certfiles  /organizations/fabric-ca/ordererOrg/tls-cert.pem
  { set +x; } 2>/dev/null

  echo "Register orderer5"
  set -x
  fabric-ca-client register --caname ca-orderer --id.name orderer5 --id.secret ordererpw --id.type orderer --tls.certfiles  /organizations/fabric-ca/ordererOrg/tls-cert.pem
  { set +x; } 2>/dev/null




  echo "Register the orderer admin"
  set -x
  fabric-ca-client register --caname ca-orderer --id.name ordererAdmin --id.secret ordererAdminpw --id.type admin --tls.certfiles /organizations/fabric-ca/ordererOrg/tls-cert.pem
  { set +x; } 2>/dev/null

  mkdir -p organizations/ordererOrganizations/agrinet.com/orderers

  mkdir -p organizations/ordererOrganizations/agrinet.com/orderers/orderer.agrinet.com

  echo "Generate the orderer msp"
  set -x
  fabric-ca-client enroll -u https://orderer:ordererpw@ca-orderer:10054 --caname ca-orderer -M /organizations/ordererOrganizations/agrinet.com/orderers/orderer.agrinet.com/msp --csr.hosts orderer.agrinet.com --csr.hosts localhost --csr.hosts ca-orderer --csr.hosts orderer --tls.certfiles /organizations/fabric-ca/ordererOrg/tls-cert.pem
  { set +x; } 2>/dev/null

  cp /organizations/ordererOrganizations/agrinet.com/msp/config.yaml /organizations/ordererOrganizations/agrinet.com/orderers/orderer.agrinet.com/msp/config.yaml

  echo "Generate the orderer-tls certificates"
  set -x
  fabric-ca-client enroll -u https://orderer:ordererpw@ca-orderer:10054 --caname ca-orderer -M /organizations/ordererOrganizations/agrinet.com/orderers/orderer.agrinet.com/tls --enrollment.profile tls --csr.hosts orderer.agrinet.com --csr.hosts localhost --csr.hosts ca-orderer --csr.hosts orderer --tls.certfiles /organizations/fabric-ca/ordererOrg/tls-cert.pem
  { set +x; } 2>/dev/null

  cp /organizations/ordererOrganizations/agrinet.com/orderers/orderer.agrinet.com/tls/tlscacerts/* /organizations/ordererOrganizations/agrinet.com/orderers/orderer.agrinet.com/tls/ca.crt
  cp /organizations/ordererOrganizations/agrinet.com/orderers/orderer.agrinet.com/tls/signcerts/* /organizations/ordererOrganizations/agrinet.com/orderers/orderer.agrinet.com/tls/server.crt
  cp /organizations/ordererOrganizations/agrinet.com/orderers/orderer.agrinet.com/tls/keystore/* /organizations/ordererOrganizations/agrinet.com/orderers/orderer.agrinet.com/tls/server.key

  mkdir -p /organizations/ordererOrganizations/agrinet.com/orderers/orderer.agrinet.com/msp/tlscacerts
  cp /organizations/ordererOrganizations/agrinet.com/orderers/orderer.agrinet.com/tls/tlscacerts/* /organizations/ordererOrganizations/agrinet.com/orderers/orderer.agrinet.com/msp/tlscacerts/tlsca.agrinet.com-cert.pem

  mkdir -p /organizations/ordererOrganizations/agrinet.com/msp/tlscacerts
  cp /organizations/ordererOrganizations/agrinet.com/orderers/orderer.agrinet.com/tls/tlscacerts/* /organizations/ordererOrganizations/agrinet.com/msp/tlscacerts/tlsca.agrinet.com-cert.pem

  mkdir -p organizations/ordererOrganizations/agrinet.com/users
  mkdir -p organizations/ordererOrganizations/agrinet.com/users/Admin@agrinet.com


  # -----------------------------------------------------------------------
  #  Orderer 2

  mkdir -p organizations/ordererOrganizations/agrinet.com/orderers/orderer2.agrinet.com

  echo "Generate the orderer2 msp"
  set -x
  fabric-ca-client enroll -u https://orderer:ordererpw@ca-orderer:10054 --caname ca-orderer -M /organizations/ordererOrganizations/agrinet.com/orderers/orderer2.agrinet.com/msp --csr.hosts orderer2.agrinet.com --csr.hosts localhost --csr.hosts ca-orderer --csr.hosts orderer2 --tls.certfiles /organizations/fabric-ca/ordererOrg/tls-cert.pem
  { set +x; } 2>/dev/null

  cp /organizations/ordererOrganizations/agrinet.com/msp/config.yaml /organizations/ordererOrganizations/agrinet.com/orderers/orderer2.agrinet.com/msp/config.yaml

  echo "Generate the orderer2-tls certificates"
  set -x
  fabric-ca-client enroll -u https://orderer:ordererpw@ca-orderer:10054 --caname ca-orderer -M /organizations/ordererOrganizations/agrinet.com/orderers/orderer2.agrinet.com/tls --enrollment.profile tls --csr.hosts orderer2.agrinet.com --csr.hosts localhost --csr.hosts ca-orderer2 --csr.hosts orderer2 --tls.certfiles /organizations/fabric-ca/ordererOrg/tls-cert.pem
  { set +x; } 2>/dev/null

  cp /organizations/ordererOrganizations/agrinet.com/orderers/orderer2.agrinet.com/tls/tlscacerts/* /organizations/ordererOrganizations/agrinet.com/orderers/orderer2.agrinet.com/tls/ca.crt
  cp /organizations/ordererOrganizations/agrinet.com/orderers/orderer2.agrinet.com/tls/signcerts/* /organizations/ordererOrganizations/agrinet.com/orderers/orderer2.agrinet.com/tls/server.crt
  cp /organizations/ordererOrganizations/agrinet.com/orderers/orderer2.agrinet.com/tls/keystore/* /organizations/ordererOrganizations/agrinet.com/orderers/orderer2.agrinet.com/tls/server.key

  mkdir -p /organizations/ordererOrganizations/agrinet.com/orderers/orderer2.agrinet.com/msp/tlscacerts
  cp /organizations/ordererOrganizations/agrinet.com/orderers/orderer2.agrinet.com/tls/tlscacerts/* /organizations/ordererOrganizations/agrinet.com/orderers/orderer2.agrinet.com/msp/tlscacerts/tlsca.agrinet.com-cert.pem

  mkdir -p /organizations/ordererOrganizations/agrinet.com/msp/tlscacerts
  cp /organizations/ordererOrganizations/agrinet.com/orderers/orderer2.agrinet.com/tls/tlscacerts/* /organizations/ordererOrganizations/agrinet.com/msp/tlscacerts/tlsca.agrinet.com-cert.pem



  # -----------------------------------------------------------------------
  #  Orderer 3

  mkdir -p organizations/ordererOrganizations/agrinet.com/orderers/orderer3.agrinet.com

  echo "Generate the orderer3 msp"
  set -x
  fabric-ca-client enroll -u https://orderer:ordererpw@ca-orderer:10054 --caname ca-orderer -M /organizations/ordererOrganizations/agrinet.com/orderers/orderer3.agrinet.com/msp --csr.hosts orderer3.agrinet.com --csr.hosts localhost --csr.hosts ca-orderer --csr.hosts orderer3 --tls.certfiles /organizations/fabric-ca/ordererOrg/tls-cert.pem
  { set +x; } 2>/dev/null

  cp /organizations/ordererOrganizations/agrinet.com/msp/config.yaml /organizations/ordererOrganizations/agrinet.com/orderers/orderer3.agrinet.com/msp/config.yaml

  echo "Generate the orderer3-tls certificates"
  set -x
  fabric-ca-client enroll -u https://orderer:ordererpw@ca-orderer:10054 --caname ca-orderer -M /organizations/ordererOrganizations/agrinet.com/orderers/orderer3.agrinet.com/tls --enrollment.profile tls --csr.hosts orderer3.agrinet.com --csr.hosts localhost --csr.hosts ca-orderer --csr.hosts orderer3 --tls.certfiles /organizations/fabric-ca/ordererOrg/tls-cert.pem
  { set +x; } 2>/dev/null

  cp /organizations/ordererOrganizations/agrinet.com/orderers/orderer3.agrinet.com/tls/tlscacerts/* /organizations/ordererOrganizations/agrinet.com/orderers/orderer3.agrinet.com/tls/ca.crt
  cp /organizations/ordererOrganizations/agrinet.com/orderers/orderer3.agrinet.com/tls/signcerts/* /organizations/ordererOrganizations/agrinet.com/orderers/orderer3.agrinet.com/tls/server.crt
  cp /organizations/ordererOrganizations/agrinet.com/orderers/orderer3.agrinet.com/tls/keystore/* /organizations/ordererOrganizations/agrinet.com/orderers/orderer3.agrinet.com/tls/server.key

  mkdir -p /organizations/ordererOrganizations/agrinet.com/orderers/orderer3.agrinet.com/msp/tlscacerts
  cp /organizations/ordererOrganizations/agrinet.com/orderers/orderer3.agrinet.com/tls/tlscacerts/* /organizations/ordererOrganizations/agrinet.com/orderers/orderer3.agrinet.com/msp/tlscacerts/tlsca.agrinet.com-cert.pem

  mkdir -p /organizations/ordererOrganizations/agrinet.com/msp/tlscacerts
  cp /organizations/ordererOrganizations/agrinet.com/orderers/orderer3.agrinet.com/tls/tlscacerts/* /organizations/ordererOrganizations/agrinet.com/msp/tlscacerts/tlsca.agrinet.com-cert.pem




  # -----------------------------------------------------------------------
  #  Orderer 4

  mkdir -p organizations/ordererOrganizations/agrinet.com/orderers/orderer4.agrinet.com

  echo "Generate the orderer4 msp"
  set -x
  fabric-ca-client enroll -u https://orderer:ordererpw@ca-orderer:10054 --caname ca-orderer -M /organizations/ordererOrganizations/agrinet.com/orderers/orderer4.agrinet.com/msp --csr.hosts orderer4.agrinet.com --csr.hosts localhost --csr.hosts ca-orderer --csr.hosts orderer4 --tls.certfiles /organizations/fabric-ca/ordererOrg/tls-cert.pem
  { set +x; } 2>/dev/null

  cp /organizations/ordererOrganizations/agrinet.com/msp/config.yaml /organizations/ordererOrganizations/agrinet.com/orderers/orderer4.agrinet.com/msp/config.yaml

  echo "Generate the orderer4-tls certificates"
  set -x
  fabric-ca-client enroll -u https://orderer:ordererpw@ca-orderer:10054 --caname ca-orderer -M /organizations/ordererOrganizations/agrinet.com/orderers/orderer4.agrinet.com/tls --enrollment.profile tls --csr.hosts orderer4.agrinet.com --csr.hosts localhost --csr.hosts ca-orderer4 --csr.hosts orderer4 --tls.certfiles /organizations/fabric-ca/ordererOrg/tls-cert.pem
  { set +x; } 2>/dev/null

  cp /organizations/ordererOrganizations/agrinet.com/orderers/orderer4.agrinet.com/tls/tlscacerts/* /organizations/ordererOrganizations/agrinet.com/orderers/orderer4.agrinet.com/tls/ca.crt
  cp /organizations/ordererOrganizations/agrinet.com/orderers/orderer4.agrinet.com/tls/signcerts/* /organizations/ordererOrganizations/agrinet.com/orderers/orderer4.agrinet.com/tls/server.crt
  cp /organizations/ordererOrganizations/agrinet.com/orderers/orderer4.agrinet.com/tls/keystore/* /organizations/ordererOrganizations/agrinet.com/orderers/orderer4.agrinet.com/tls/server.key

  mkdir -p /organizations/ordererOrganizations/agrinet.com/orderers/orderer4.agrinet.com/msp/tlscacerts
  cp /organizations/ordererOrganizations/agrinet.com/orderers/orderer4.agrinet.com/tls/tlscacerts/* /organizations/ordererOrganizations/agrinet.com/orderers/orderer4.agrinet.com/msp/tlscacerts/tlsca.agrinet.com-cert.pem

  mkdir -p /organizations/ordererOrganizations/agrinet.com/msp/tlscacerts
  cp /organizations/ordererOrganizations/agrinet.com/orderers/orderer4.agrinet.com/tls/tlscacerts/* /organizations/ordererOrganizations/agrinet.com/msp/tlscacerts/tlsca.agrinet.com-cert.pem




  # -----------------------------------------------------------------------
  #  Orderer 5

  mkdir -p organizations/ordererOrganizations/agrinet.com/orderers/orderer5.agrinet.com

  echo "Generate the orderer5 msp"
  set -x
  fabric-ca-client enroll -u https://orderer:ordererpw@ca-orderer:10054 --caname ca-orderer -M /organizations/ordererOrganizations/agrinet.com/orderers/orderer5.agrinet.com/msp --csr.hosts orderer5.agrinet.com --csr.hosts localhost --csr.hosts ca-orderer --csr.hosts orderer5 --tls.certfiles /organizations/fabric-ca/ordererOrg/tls-cert.pem
  { set +x; } 2>/dev/null

  cp /organizations/ordererOrganizations/agrinet.com/msp/config.yaml /organizations/ordererOrganizations/agrinet.com/orderers/orderer5.agrinet.com/msp/config.yaml

  echo "Generate the orderer5-tls certificates"
  set -x
  fabric-ca-client enroll -u https://orderer:ordererpw@ca-orderer:10054 --caname ca-orderer -M /organizations/ordererOrganizations/agrinet.com/orderers/orderer5.agrinet.com/tls --enrollment.profile tls --csr.hosts orderer5.agrinet.com --csr.hosts localhost --csr.hosts ca-orderer5 --csr.hosts orderer5 --tls.certfiles /organizations/fabric-ca/ordererOrg/tls-cert.pem
  { set +x; } 2>/dev/null

  cp /organizations/ordererOrganizations/agrinet.com/orderers/orderer5.agrinet.com/tls/tlscacerts/* /organizations/ordererOrganizations/agrinet.com/orderers/orderer5.agrinet.com/tls/ca.crt
  cp /organizations/ordererOrganizations/agrinet.com/orderers/orderer5.agrinet.com/tls/signcerts/* /organizations/ordererOrganizations/agrinet.com/orderers/orderer5.agrinet.com/tls/server.crt
  cp /organizations/ordererOrganizations/agrinet.com/orderers/orderer5.agrinet.com/tls/keystore/* /organizations/ordererOrganizations/agrinet.com/orderers/orderer5.agrinet.com/tls/server.key

  mkdir -p /organizations/ordererOrganizations/agrinet.com/orderers/orderer5.agrinet.com/msp/tlscacerts
  cp /organizations/ordererOrganizations/agrinet.com/orderers/orderer5.agrinet.com/tls/tlscacerts/* /organizations/ordererOrganizations/agrinet.com/orderers/orderer5.agrinet.com/msp/tlscacerts/tlsca.agrinet.com-cert.pem

  mkdir -p /organizations/ordererOrganizations/agrinet.com/msp/tlscacerts
  cp /organizations/ordererOrganizations/agrinet.com/orderers/orderer5.agrinet.com/tls/tlscacerts/* /organizations/ordererOrganizations/agrinet.com/msp/tlscacerts/tlsca.agrinet.com-cert.pem



  echo "Generate the admin msp"
  set -x
  fabric-ca-client enroll -u https://ordererAdmin:ordererAdminpw@ca-orderer:10054 --caname ca-orderer -M /organizations/ordererOrganizations/agrinet.com/users/Admin@agrinet.com/msp --tls.certfiles /organizations/fabric-ca/ordererOrg/tls-cert.pem
  { set +x; } 2>/dev/null

  cp /organizations/ordererOrganizations/agrinet.com/msp/config.yaml /organizations/ordererOrganizations/agrinet.com/users/Admin@agrinet.com/msp/config.yaml
