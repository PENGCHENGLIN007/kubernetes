##删除service
kubectl get svc -n=pcl

kubectl delete svc mysql -n=pcl
kubectl delete svc mysql-read -n=pcl

##删除staatefulset
kubectl get statefulset -n=pcl

kubectl delete statefulset mysql -n=pcl

##删除pvc
kubectl get pvc -n=pcl

kubectl delete pvc xxx -n=pcl

##删除pv
kubectl get pv -n=pcl

kubectl delete pv xxx -n=pcl

##删除configmap

kubectl get configmap -n=pcl

kubectl delete configmap xxx -n=pcl

##查询pods

kubectl get pods -o wide  -n=pcl
kubectl describe pod mysql-0   -n=pcl 



1）通过运行一个临时的容器(使用mysql:5.7镜像)，使用MySQL 客户端发送测试请求给MySQL master节点
（主机名为mysql-0.mysql；跨命名空间的话，主机名请使用mysql-0.mysql.kube-public）


 在master节点上创建demo数据库，并创建一个只有message字段的demo.messages的表，并为message字段插入hello值。
`$ kubectl run mysql-client --image=mysql:5.7 -it --rm --restart=Never -- mysql -h mysql-0.mysql.kube-public`

`CREATE DATABASE demo; 
 CREATE TABLE demo.messages (message VARCHAR(250)); 
 INSERT INTO demo.messages VALUES ('hello');`
 
 
 2）使用主机名为mysql-read来发送测试请求给服务器：

`$ kubectl run mysql-client --image=mysql:5.7 -i -t --rm --restart=Never -- mysql -h mysql-read.kube-public`

`SELECT * FROM demo.messages;`

 
 