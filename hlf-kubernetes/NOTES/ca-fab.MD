# Affiliations

## Kube Orderer, fabsamp org 3,2,1, Orderer
```yaml
#############################################################################
# Affiliations section. Fabric CA server can be bootstrapped with the
# affiliations specified in this section. Affiliations are specified as maps.
# For example:
#   businessunit1:
#     department1:
#       - team1
#   businessunit2:
#     - department2
#     - department3
#
# Affiliations are hierarchical in nature. In the above example,
# department1 (used as businessunit1.department1) is the child of businessunit1.
# team1 (used as businessunit1.department1.team1) is the child of department1.
# department2 (used as businessunit2.department2) and department3 (businessunit2.department3)
# are children of businessunit2.
# Note: Affiliations are case sensitive except for the non-leaf affiliations
# (like businessunit1, department1, businessunit2) that are specified in the configuration file,
# which are always stored in lower case.
#############################################################################
affiliations:
   org1:
      - department1
      - department2
   org2:
      - department1

```
## kube org 1,2,3
```yaml
#############################################################################
# Affiliations section. Fabric CA server can be bootstrapped with the
# affiliations specified in this section. Affiliations are specified as maps.
# For example:
#   businessunit1:
#     department1:
#       - team1
#   businessunit2:
#     - department2
#     - department3
#
# Affiliations are hierarchical in nature. In the above example,
# department1 (used as businessunit1.department1) is the child of businessunit1.
# team1 (used as businessunit1.department1.team1) is the child of department1.
# department2 (used as businessunit2.department2) and department3 (businessunit2.department3)
# are children of businessunit2.
# Note: Affiliations are case sensitive except for the non-leaf affiliations
# (like businessunit1, department1, businessunit2) that are specified in the configuration file,
# which are always stored in lower case.
#############################################################################
affiliations:
   org1:
      - department1
      - department2
   org2:
      - department1
   org3:
      - department1

```

# DFarm

```yaml
###########################################################################
#  Certificate Signing Request (CSR) section.
###########################################################################
csr:
  cn: root.caserver
  keyrequest:
    algo: ecdsa
    size: 256
  names:
    - C: US
      ST: "New Jersey"
      L:
      O: Dfarmadmin
      OU: Support
  hosts:
    - root.caserver.com
    - localhost
  ca:
    expiry: 131400h
    pathlength: 1

```

```yaml
#############################################################################
# Affiliations 
#############################################################################
affiliations:
  dfarmadmin:
    - logistics
    - accounting
    - b2b
  orderer:
    - support
  dfarmretail:
    - b2b
```

## Template
- businessunit1:
  department1:
    - team1
- businessunit2:
    - department2
    - department3

## Agrinetcom
- 
```yaml
affiliations:
  farmer:
    - harvesting
    - mediation
  middleman:
    - harvesting
    - mediation
  processor:
    - mediation
    - processing
    - storage
  storage:
    - logistics
    - storage
  regulator:
    - processing
  distributor:
    - storage
    - logistics
  retailer:
    - logistics
    - sales 
```

# Certificate Signing Request (CSR)

## Orderer
```yaml
csr:
   cn: ca.example.com
   names:
      - C: US
        ST: "New York"
        L: "New York"
        O: example.com
        OU:
   hosts:
     - localhost
     - example.com
   ca:
      expiry: 131400h
      pathlength: 1
```

```yaml
csr:
   cn: ca-org1
   names:
      - C: US
        ST: "New York"
        L: "New York"
        O: example.com
        OU:
   hosts:
     - localhost
     - example.com
     - ca-orderer
   ca:
      expiry: 131400h
      pathlength: 1
```

## Org 1
```yaml
csr:
   cn: ca.org1.example.com
   names:
      - C: US
        ST: "North Carolina"
        L: "Durham"
        O: org1.example.com
        OU:
   hosts:
     - localhost
     - org1.example.com
   ca:
      expiry: 131400h
      pathlength: 1
```

```yaml
csr:
   cn: ca-org1
   names:
      - C: US
        ST: "New York"
        L: "New York"
        O: ca-org1
        OU: ca-org1
   hosts:
     - localhost
     - example.com
     - ca-org1
   ca:
      expiry: 131400h
      pathlength: 1
```

## Org 2
```yaml
csr:
   cn: ca.org2.example.com
   names:
      - C: UK
        ST: "Hampshire"
        L: "Hursley"
        O: org2.example.com
        OU:
   hosts:
     - localhost
     - org2.example.com
   ca:
      expiry: 131400h
      pathlength: 1

```

```yaml
csr:
   cn: ca-org2
   names:
      - C: US
        ST: "New York"
        L: "New York"
        O: ca-org2
        OU: ca-org2
   hosts:
     - localhost
     - example.com
     - ca-org2
   ca:
      expiry: 131400h
      pathlength: 1
```

## Org 3
```yaml
csr:
   cn: ca.org3.example.com
   names:
      - C: US
        ST: "North Carolina"
        L: "Raleigh"
        O: org3.example.com
        OU:
   hosts:
     - localhost
     - org3.example.com
   ca:
      expiry: 131400h
      pathlength: 1
```

```yaml
csr:
   cn: ca-org3
   names:
      - C: US
        ST: "New York"
        L: "New York"
        O: ca-org3
        OU: ca-org3
   hosts:
     - localhost
     - example.com
     - ca-org3
   ca:
      expiry: 131400h
      pathlength: 1

```

## Agrinetcom
 ### orderer
```yaml
csr:
   cn: ca-orderer
   names:
      - C: US
        ST: "New York"
        L: "New York"
        O: agrinet.com
        OU:
   hosts:
     - localhost
     - agrinet.com
     - ca-orderer
   ca:
      expiry: 131400h
      pathlength: 1
```

 ### farmer
```yaml
csr:
   cn: ca-farmer
   names:
      - C: US
        ST: "New York"
        L: "New York"
        O: ca-farmer
        OU: ca-farmer
   hosts:
     - localhost
     - agrinet.com
     - ca-farmer
   ca:
      expiry: 131400h
      pathlength: 1

```

 ### middleman
```yaml
csr:
   cn: ca-middleman
   names:
      - C: US
        ST: "New York"
        L: "New York"
        O: ca-middleman
        OU: ca-middleman
   hosts:
     - localhost
     - agrinet.com
     - ca-middleman
   ca:
      expiry: 131400h
      pathlength: 1

```

 ### processor
```yaml
csr:
   cn: ca-processor
   names:
      - C: US
        ST: "New York"
        L: "New York"
        O: ca-processor
        OU: ca-processor
   hosts:
     - localhost
     - agrinet.com
     - ca-processor
   ca:
      expiry: 131400h
      pathlength: 1

```

 ### storage
```yaml
csr:
   cn: ca-storage
   names:
      - C: US
        ST: "New York"
        L: "New York"
        O: ca-storage
        OU: ca-storage
   hosts:
     - localhost
     - agrinet.com
     - ca-storage
   ca:
      expiry: 131400h
      pathlength: 1

```

 ### regulator
```yaml
csr:
   cn: ca-regulator
   names:
      - C: US
        ST: "New York"
        L: "New York"
        O: ca-regulator
        OU: ca-regulator
   hosts:
     - localhost
     - agrinet.com
     - ca-regulator
   ca:
      expiry: 131400h
      pathlength: 1

```

 ### distributor
```yaml
csr:
   cn: ca-distributor
   names:
      - C: US
        ST: "New York"
        L: "New York"
        O: ca-distributor
        OU: ca-distributor
   hosts:
     - localhost
     - agrinet.com
     - ca-distributor
   ca:
      expiry: 131400h
      pathlength: 1

```

 ### retailer
```yaml
csr:
   cn: ca-retailer
   names:
      - C: US
        ST: "New York"
        L: "New York"
        O: ca-retailer
        OU: ca-retailer
   hosts:
     - localhost
     - agrinet.com
     - ca-retailer
   ca:
      expiry: 131400h
      pathlength: 1

```