##创建资源

`kubectl create ns pcl`

`kubectl create -f cm.yaml`

`kubectl create -f pv.yaml`

`kubectl create -f svc.yaml`

`kubectl create -f sts.yaml`


##初始化redis

`kubectl exec -it redis-cluster-0 -n pcl  -- redis-cli  --cluster create --cluster-replicas 1 $(kubectl get pods -n pcl -l app=redis-cluster -o jsonpath='{range.items[*]}{.status.podIP}:6379 ')`

##验证集群信息
`kubectl exec -it redis-cluster-0 -n pcl -- redis-cli cluster info`

`kubectl exec -it redis-cluster-4 -n pcl -- redis-cli cluster nodes`

`redis-cli -c -p 6379`

`for x in $(seq 0 5); do echo "redis-cluster-$x"; kubectl exec redis-cluster-$x -n pcl -- redis-cli role; echo; done`

##查询资源
`kubectl get configmap -n pcl`

`kubectl get pv -n pcl`

`kubectl get pvc -n pcl`

`kubectl get svc -n pcl`

`kubectl get statefulset -n pcl`

`kubectl get pod -o wide -n pcl`

##清理资源
`kubectl delete statefulset redis-cluster -n pcl`

`kubectl delete svc  redis-cluster -n pcl`

`kubectl delete configmap  redis-cluster -n pcl`

`kubectl delete pvc data-redis-cluster-0 data-redis-cluster-1 data-redis-cluster-2 data-redis-cluster-3 data-redis-cluster-4 data-redis-cluster-5 -n pcl`

`kubectl delete pv redis-pv1 redis-pv2  redis-pv3 redis-pv4 redis-pv5  redis-pv6  -n pcl`

`rm -rf /root/pcl/nfs/redis/data{1..6}/*`




