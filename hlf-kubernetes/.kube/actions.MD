```shell
kubectl apply -f ../6.configmap/builder-config.yaml --kubeconfig=config

```
```shell
farmer
middleman
processor
storage
regulator
distributor
retailer
```

```shell
kubectl apply -f ../7.peers/farmer --kubeconfig=config
kubectl apply -f ../7.peers/middleman --kubeconfig=config
kubectl apply -f ../7.peers/processor --kubeconfig=config
kubectl apply -f ../7.peers/storage --kubeconfig=config
kubectl apply -f ../7.peers/regulator --kubeconfig=config
kubectl apply -f ../7.peers/distributor --kubeconfig=config
kubectl apply -f ../7.peers/retailer --kubeconfig=config
```