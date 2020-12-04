##创建postgresql集群

###创建pv
kubectl create -f pv.yaml

###创建role
kubectl apply -f role.yaml

###创建rolebinding
kubectl apply -f role-binding.yaml


###初始化启动
kubectl run -i -t stolonctl --image=172.16.44.28:5000/sorintlab/stolon:master-pg10 --restart=Never --rm -- /usr/local/bin/stolonctl --cluster-name=kube-stolon --store-backend=kubernetes --kube-resource-kind=configmap init

###创建sentinel
kubectl create -f stolon-sentinel.yaml

###创建密码
kubectl  create -f secret.yaml 


###创建实例
kubectl apply -f stolon-keeper.yaml

###创建代理
kubectl create  -f stolon-proxy.yaml

###创建服务
kubectl create -f stolon-proxy-service.yaml

##查询

kubectl get pvc
kubectl get pv
kubectl get pod

###进入容器
kubectl exec -ti stolon-proxy-5977cdbcfc-csnkq bash
###连接pg
psql --host stolon-proxy-service   --port 5432 postgres -U stolon -W

##清理
kubectl delete pvc data-stolon-keeper-0
kubectl delete pvc data-stolon-keeper-1

kubectl delete pv pv-nfs-pg01
kubectl delete pv pv-nfs-pg02
kubectl delete pv pv-nfs-pg03

rm -rf /root/nfs/nfsdata/pgsql/data1/*
rm -rf /root/nfs/nfsdata/pgsql/data2/*
rm -rf /root/nfs/nfsdata/pgsql/data3/*

##卸载数据库

kubectl delete -f stolon.yaml