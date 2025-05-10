# Kubernetes
##How Manual Installation of Kubernetes works?
1. On linux , we need to install docker or container run time (containerD is preferred)
2. Install kuberetes solution on all the nodes and designate one of the Node as a Master & rest of the nodes are the worker nodes.
3. Once you Install Kubernetes on the master node, It offers you a TOKEN , using that TOKEN other nodes will be connected and acts as a worker nodes.
4. Ensure Kubelet is installed on all the worker nodes (Kubelet is the local leader for each worker nodes).
5. Your workloads will be running on the worker nodes.
