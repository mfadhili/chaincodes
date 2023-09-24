```shell
mkdir fabric-ca/farmer
mkdir fabric-ca/middleman
mkdir fabric-ca/processor
mkdir fabric-ca/storage
mkdir fabric-ca/regulator
mkdir fabric-ca/distributor
mkdir fabric-ca/retailer
```
```shell
cp ./fabric-ca/org1/fabric-ca-server-config.yaml ./fabric-ca/farmer
cp ./fabric-ca/org1/fabric-ca-server-config.yaml ./fabric-ca/middleman
cp ./fabric-ca/org1/fabric-ca-server-config.yaml ./fabric-ca/processor
cp ./fabric-ca/org1/fabric-ca-server-config.yaml ./fabric-ca/storage
cp ./fabric-ca/org1/fabric-ca-server-config.yaml ./fabric-ca/regulator
cp ./fabric-ca/org1/fabric-ca-server-config.yaml ./fabric-ca/distributor
cp ./fabric-ca/org1/fabric-ca-server-config.yaml ./fabric-ca/retailer
```

```shell
touch ./scripts/farmer-certs.sh
touch ./scripts/middleman-certs.sh
touch ./scripts/processor-certs.sh
touch ./scripts/storage-certs.sh
touch ./scripts/regulator-certs.sh
touch ./scripts/distributor-certs.sh
touch ./scripts/retailer-certs.sh
```
