
1. How Kubernetes knows a Pod is unhealthy
Kubernetes detects an unhealthy Pod using probes defined in the Pod spec:
Liveness probe → “Is this container still alive?”
Readiness probe → “Can this container receive traffic?”
Startup probe → “Has the app started successfully?”
These probes are executed by the kubelet on the node

2. Who takes action when a Pod becomes unhealthy?
🔹 kubelet (on the node)
Continuously runs health probes.
If a liveness probe fails, kubelet:
Kills the container
Restarts the container (inside the same Pod)

3. What if the Pod still can’t recover?
🔹 Controller (Deployment / ReplicaSet / StatefulSet)
Controllers run in the kube-controller-manager
They ensure the desired state is met (e.g., 3 replicas running)
If:
    The Pod crashes repeatedly
    The node goes down
    The Pod is deleted
Then the controller:
Creates a new Pod to replace it
⚠️ Note: Controllers do not fix a Pod—they replace it.

4. What about traffic during unhealthy state?
🔹 Service + Endpoints
If a readiness probe fails:
The Pod is marked NotReady
Kubernetes removes it from Service endpoints
Traffic is stopped until it becomes Ready again

5. how to establish the Default communication for Pods across different namespaces & command?
By default, Pods in different namespaces can communicate with each other using their fully qualified domain names (FQDNs). The FQDN format for a Pod is:
<pod-name>.<namespace>.svc.cluster.local
To establish communication between Pods in different namespaces, you can use the following command format:
curl http://<pod-name>.<namespace>.svc.cluster.local:<port>
For example, if you have a Pod named "frontend" in the "dev" namespace and you want to communicate with it from a Pod in the "prod" namespace, you would use:
curl http://frontend.dev.svc.cluster.local:80
6. How to restrict communication between Pods across different namespaces?
To restrict communication between Pods across different namespaces in Kubernetes, you can use Network Policies. Network Policies allow you to define rules that control the traffic flow between Pods based on labels and namespaces.
Here’s a basic example of a Network Policy that restricts traffic to Pods in the "dev" namespace, allowing only Pods from the same namespace to communicate with each other:
```yamlapiVersion: networking.k8s.io/v1
kind: NetworkPolicy
metadata:
  name: deny-cross-namespace
  namespace: dev
spec:
  podSelector: {}
    policyTypes:    
    - Ingress
    - Egress
  ingress:
    - from:
        - podSelector: {}
    egress:
    - to:
        - podSelector: {}
```
In this example:
- The Network Policy is applied to all Pods in the "dev" namespace (podSelector: {}).
- It allows ingress and egress traffic only from/to Pods within the same namespace (podSelector: {}).
To apply this Network Policy, save it to a file (e.g., deny-cross-namespace.yaml) and run:
kubectl apply -f deny-cross-namespace.yaml  
With this policy in place, Pods in the "dev" namespace will not be able to communicate with Pods in other namespaces unless additional rules are defined to allow such communication.

6. In Deployment file specified 5 pods should run all time, but only 3 pods are running. What could be the possible reasons & which kubernetes component will you check to troubleshoot the issue?
If a Deployment is configured to run 5 Pods but only 3 are running, there could be several possible reasons for this discrepancy. Here are some common causes and the Kubernetes components you should check to troubleshoot the issue:
1. Insufficient Resources:
2. Check Node Resources:
Use kubectl describe nodes to check if there are enough CPU and memory resources available on the nodes to schedule the additional Pods.
2. Pod Scheduling Issues:
3. Check Pod Events:
Use kubectl describe deployment <deployment-name> to view events related to the Deployment. Look for any scheduling errors or issues preventing Pods from being created.
4. Check Pod Status:
5. Use kubectl get pods to see the status of all Pods. Look for Pods in Pending or Failed states and investigate further using kubectl describe pod <pod-name>.
6. Image Pull Errors:
7. Check Container Logs:
Use kubectl logs <pod-name> to check for any errors related to pulling the container image.
8. Check Events:    
Use kubectl describe pod <pod-name> to see if there are any image pull errors in the events section.
9. Node Affinity or Taints/Tolerations:
10. Check Node Affinity Rules:
Use kubectl describe deployment <deployment-name> to check if there are any node affinity rules or taints/tolerations that might be preventing Pods from being scheduled on certain nodes.
11. Check Node Taints:    
Use kubectl describe nodes to see if any nodes are tainted in a way that prevents Pods from being scheduled.
12. Deployment Configuration Issues:
13. Check Deployment Spec:
Review the Deployment YAML file to ensure that the replica count is correctly set to 5 and that there are no misconfigurations.
14. Check for Rollout Status:   
15. Use kubectl rollout status deployment/<deployment-name> to check if the Deployment is in a healthy state.
By systematically checking these components, you should be able to identify the root cause of why only  3 Pods are running instead of the desired 5 and take appropriate action to resolve the issue.
