echo " EKS and application deployment initiated "
sleep 10s
echo " Deploying EKS cluster "
cd /home/EKS_CLUSTER && terraform init && terraform apply -var cluster-name1=$1 -var aws-region=$2 -var node-instance-type=$3 -var KeyName=$4 --auto-approve
sleep 1m
echo " Updating the kubeconfig and authentication file"
cd /home/EKS_CLUSTER && terraform output kubeconfig1 > kubeconfig  && terraform output config-map1 > aws-auth-cm-cluster1.yaml
sleep 20s
echo " Deploying EKS worker node "
cd /home/EKS_CLUSTER && kubectl apply -f aws-auth-cm-cluster1.yaml --kubeconfig=kubeconfig
sleep 60s
echo " Creating service account, namespaces and application on the EKS cluster created "
cd /home/EKS_CLUSTER && kubectl create ns sock-shop --kubeconfig=kubeconfig && kubectl create ns dryice-eks-dashboard --kubeconfig=kubeconfig && kubectl create ns dryice-eks --kubeconfig=kubeconfig
##############################################
echo "Getting the nodes and pods deployed"
cd /home/EKS_CLUSTER && kubectl get nodes --kubeconfig=kubeconfig

sleep 30s
########################################################################################################
