##安装
###创建nfs共享目录
mkdir -p /data3/nfs/zk/{zk01,zk02,zk03}
###修改目录权限
否则zk-0报错，没有创建权限
chmod 777 /data3/nfs/zk/zk01
chmod 777 /data3/nfs/zk/zk02
chmod 777 /data3/nfs/zk/zk03
###创建pv
kubectl create -f pv.yaml
###创建服务
kubectl apply -f zookeeper.yaml

##查询
###获取pod主机名
for i in 0 1 2; do kubectl exec zk-$i -- hostname; done

###获取myid内容
for i in 0 1 2; do echo "myid zk-$i";kubectl exec zk-$i -- cat /var/lib/zookeeper/data/myid; done

###获取pod全限定名称（FQDN）
for i in 0 1 2; do kubectl exec zk-$i -- hostname -f; done

示例：
zk-0.zk-hs.default.svc.cluster.local
zk-1.zk-hs.default.svc.cluster.local
zk-2.zk-hs.default.svc.cluster.local

###查看conf
kubectl exec zk-0 -- cat /opt/zookeeper/conf/zoo.cfg


##测试

###zk-0写入数据
kubectl exec zk-0 zkCli.sh create /hello world

###zk-1查询数据
kubectl exec zk-1 zkCli.sh get /hello

###持久化测试

####删除statefulset
kubectl delete statefulset zk

####查看状态变化
kubectl get pods -w -l app=zk

####重新启动
kubectl apply -f zookeeper.yaml

####查看状态变化
kubectl get pods -w -l app=zk



####zk-2查询数据
kubectl exec zk-2 zkCli.sh get /hello


####外部程序访问
sh zkCli.sh -server 172.16.44.32:31811
create /test ""