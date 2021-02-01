echo " creating sysdig agent namespace"
cd /home/agent-files && kubectl create ns sysdig-agent --kubeconfig=/home/EKS_CLUSTER/kubeconfig
echo " Create association with demon set file "
cd /home/agent-files && kubectl apply -f sysdig-agent-daemonset-v2.yaml -n sysdig-agent --kubeconfig=/home/EKS_CLUSTER/kubeconfig
echo "creating secrets for sysdig access"
cd /home/agent-files && kubectl create secret generic sysdig-agent --from-literal=access-key=XXXXXXXXXXXX -n sysdig-agent --kubeconfig=/home/EKS_CLUSTER/kubeconfig
echo " deploying sysdig agnet cluster role"
cd /home/agent-files && kubectl apply -f sysdig-agent-clusterrole.yaml -n sysdig-agent --kubeconfig=/home/EKS_CLUSTER/kubeconfig
echo "creating a service account in sysdig namespace"
cd /home/agent-files && kubectl create serviceaccount sysdig-agent -n sysdig-agent --kubeconfig=/home/EKS_CLUSTER/kubeconfig
echo "creating a cluster role binding in sysdig namespace"
cd /home/agent-files && kubectl create clusterrolebinding sysdig-agent --clusterrole=sysdig-agent --serviceaccount=sysdig-agent:sysdig-agent --kubeconfig=/home/EKS_CLUSTER/kubeconfig
echo "applying config map  in sysdig namespace"
cd /home/agent-files && export cluster_name=$1 && envsubst < sysdig-agent-configmap.yaml | kubectl apply -n sysdig-agent --kubeconfig=/home/EKS_CLUSTER/kubeconfig -f -
kubectl apply -f sysdig-agent-daemonset-v2.yaml -n sysdig-agent --kubeconfig=/home/EKS_CLUSTER/kubeconfig
