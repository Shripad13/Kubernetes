# Explain your Kubernetes setup in your project.
We have a Kubernetes cluster with 5 nodes, each node has 4 vCPUs and 8GB RAM. We are using Kubernetes version 1.24. The cluster is set up on AWS using EKS (Elastic Kubernetes Service). We have configured the cluster with the following components:
- **Namespace**: We have created separate namespaces for different environments (dev, staging, production).
- **Deployments**: We have multiple deployments for our microservices, each with its own deployment configuration, including replica count, resource requests, and limits.
- **Services**: We are using ClusterIP services for internal communication between microservices and LoadBalancer services for exposing our applications to the internet.
- **Ingress Controller**: We have an NGINX Ingress Controller set up to manage external access to our services, with SSL termination and path-based routing.
- **ConfigMaps and Secrets**: We are using ConfigMaps to manage configuration data and Secrets to securely store sensitive information like database credentials and API keys.
- **Monitoring and Logging**: We have Prometheus and Grafana set up for monitoring, and we are using Fluentd to collect and forward logs to a centralized logging system.

1. See Crashed container logs
    $ kubectl  logs pod_name --previous

2. Jump to what broke
   $ kubectl describe pod |grep Events

3. Find all failed pods
   $ kubectl get pods --field-selector=status.phase=Failed

4. Find the memory hog
   $ kubectl top pods --sort-by=memory

5. Oneline rollback
   $ kubectl rollout undo deployment/<name>
   
6. Debug without exposing
   $ kubectl port-forward svc/<name> 8080:80            


7. How Kubernetes knows a Pod is unhealthy
Kubernetes detects an unhealthy Pod using probes defined in the Pod spec:
Liveness probe → “Is this container still alive?”
Readiness probe → “Can this container receive traffic?”
Startup probe → “Has the app started successfully?”
These probes are executed by the kubelet on the node

1. Who takes action when a Pod becomes unhealthy?
🔹 kubelet (on the node)
Continuously runs health probes.
If a liveness probe fails, kubelet:
Kills the container
Restarts the container (inside the same Pod)

1. What if the Pod still can’t recover?
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

1. What about traffic during unhealthy state?
🔹 Service + Endpoints
If a readiness probe fails:
The Pod is marked NotReady
Kubernetes removes it from Service endpoints
Traffic is stopped until it becomes Ready again

1. how to establish the Default communication for Pods across different namespaces & command?
By default, Pods in different namespaces can communicate with each other using their fully qualified domain names (FQDNs). The FQDN format for a Pod is:
<pod-name>.<namespace>.svc.cluster.local
To establish communication between Pods in different namespaces, you can use the following command format:
curl http://<pod-name>.<namespace>.svc.cluster.local:<port>
For example, if you have a Pod named "frontend" in the "dev" namespace and you want to communicate with it from a Pod in the "prod" namespace, you would use:
curl http://frontend.dev.svc.cluster.local:80

1. How to restrict communication between Pods across different namespaces?
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

1. In Deployment file specified 5 pods should run all time, but only 3 pods are running. What could be the possible reasons & which kubernetes component will you check to troubleshoot the issue?
If a Deployment is configured to run 5 Pods but only 3 are running, there could be several possible reasons for this discrepancy. Here are some common causes and the Kubernetes components you should check to troubleshoot the issue:
1. Insufficient Resources:
2. Check Node Resources:
Use kubectl describe nodes to check if there are enough CPU and memory resources available on the nodes to schedule the additional Pods.
1. Pod Scheduling Issues:
2. Check Pod Events:
Use kubectl describe deployment <deployment-name> to view events related to the Deployment. Look for any scheduling errors or issues preventing Pods from being created.
1. Check Pod Status:
2. Use kubectl get pods to see the status of all Pods. Look for Pods in Pending or Failed states and investigate further using kubectl describe pod <pod-name>.
3. Image Pull Errors:
4. Check Container Logs:
Use kubectl logs <pod-name> to check for any errors related to pulling the container image.
1. Check Events:    
Use kubectl describe pod <pod-name> to see if there are any image pull errors in the events section.
1. Node Affinity or Taints/Tolerations:
2.  Check Node Affinity Rules:
Use kubectl describe deployment <deployment-name> to check if there are any node affinity rules or taints/tolerations that might be preventing Pods from being scheduled on certain nodes.
1.  Check Node Taints:    
Use kubectl describe nodes to see if any nodes are tainted in a way that prevents Pods from being scheduled.
1.  Deployment Configuration Issues:
2.  Check Deployment Spec:
Review the Deployment YAML file to ensure that the replica count is correctly set to 5 and that there are no misconfigurations.
1.  Check for Rollout Status:   
2.  Use kubectl rollout status deployment/<deployment-name> to check if the Deployment is in a healthy state.
By systematically checking these components, you should be able to identify the root cause of why only  3 Pods are running instead of the desired 5 and take appropriate action to resolve the issue.


# what node level changes would you do to improve fault tolerance for your pods?
Should you allow k8s to schedule all pods on the same node by default? No
We will use Pod Anti-Affinity resource, this will tell k8s to dont schedule this pod on a node, that already has another pod with label app: myapp.
but it is ignored when the pod is scheduled or starts Running.

# What Is Pod & Node Affinity / Anti-Affinity?
This tests your scheduling intelligence and how you handle high availability.

* Node Affinity: Controls which specific nodes a pod can run on (e.g., ensuring GPU workloads land on GPU-capable nodes).
* Pod Anti-Affinity: Used to run pods apart, such as spreading replicas across different availability zones to improve fault tolerance.

# If you update congiuration for pods & not reflecting pod
1. you can trigger yaml by rolling update
2. you can delete the pod, new pod will be created with updated configuration.

# Can You Explain the Different Types of Kubernetes Deployments?
This question tests your understanding of availability, risk, and release strategies. I expect you to know when to use each, not just their definitions.

Recreate: All existing pods are terminated before new ones are created, causing downtime.

Rolling Update (Default): Pods are updated gradually to ensure zero or minimal downtime.

Blue-Green: Two identical environments exist; traffic switches instantly between them for instant rollbacks.

Canary: The new version is released to a small subset of users to monitor performance before a full rollout.

# Ingress Controller -
Ingress is a Kubernetes API object that defines routing rules for external HTTP/HTTPS traffic.

# How traffic really flows
Client
  ↓
Load Balancer (cloud or bare metal)
  ↓
Ingress Controller (NGINX / ALB / Traefik)
  ↓
Ingress rules
  ↓
Kubernetes Service
  ↓
Pods

# Why use Ingress Controller?
1. Consolidated Routing: Manage all HTTP/HTTPS routing rules in one place.
2. SSL Termination: Handle SSL/TLS termination at the Ingress level.
3. Path-Based Routing: Route traffic based on URL paths (e.g., /api → API service, /web → web service).
4. Host-Based Routing: Route traffic based on hostnames (e.g., api.example.com → API service).
5. Cost Efficiency: Reduce the number of external load balancers needed.

# When you’d use Ingress vs Service types
Service (LoadBalancer)
→ Simple, one service = one IP
Ingress
→ Multiple apps, shared domain, path-based routing, TLS, cost-efficient


# Kubernetes add-ons
Kubernetes add-ons are extra components you install on top of a Kubernetes cluster to give it capabilities that aren’t part of the bare-minimum core.
Kubernetes itself mainly does scheduling and orchestration. Add-ons handle the everything else.

Most add-ons run as pods inside the cluster, usually in the kube-system namespace.
What add-ons do; They typically provide:
1. CNI   - → Pod-to-pod networking and network policies
2. DNS and service discovery - → Lets services find each other using names instead of IPs
(my-service.default.svc.cluster.local)
3. Metrics and monitoring -→ required for kubectl top
4. Logging --→ Centralized logs from all pods and nodes
5. Ingress / traffic routing -→ HTTP/HTTPS routing into the cluster
6. Security and policy enforcement
7. Storage helpers → Connect Kubernetes to cloud disks (EBS, GCE PD, Azure Disk) or on-prem storage

# How add-ons are installed
Automatically (managed Kubernetes like EKS, GKE, AKS)
Helm charts
kubectl apply with YAML


# for Database (for StatefulSets) Pod which service you use in Kubernetes ?
✅ ClusterIP Service
✅ Often combined with a Headless Service (for StatefulSets)
❌ Rarely NodePort / LoadBalancer (not recommended for DB exposure)

# 1️⃣ ClusterIP Service
This is the standard production setup.
Use this when:
Your DB is accessed only inside the cluster
Backend apps connect to it internally

Example: App → postgres-service.default.svc.cluster.local

# 2️⃣ If Using StatefulSet → Headless Service (Very Important)

If your DB runs as a StatefulSet, you should use: clusterIP: None → Headless Service
It gives each pod a stable DNS identity:
postgres-0.db-service.default.svc.cluster.local
postgres-1.db-service.default.svc.cluster.local

This is required for:
Replication
Leader election
Cluster communication

# for Database Pod what will you use in kubernetes VPA or HPA?
✅ Use VPA (Vertical Pod Autoscaler)
❌ Avoid HPA (Horizontal Pod Autoscaler) in most cases

Benefits of VPA for DB:
Adjusts memory as dataset grows - Memory & CPU
Prevents OOMKills
Right-sizes CPU for workload
Maintains single instance stability
👉 Databases usually need more RAM, not more replicas.

🔹 Why HPA Is Usually Not Good for Databases ? - Scales number of Pods & Works best for stateless apps
Databases:
Maintain state
Require replication setup for scaling
Can’t just spin up new pods without replication or clustering config

If you scale a DB pod with HPA:
You may create inconsistent replicas
Risk split-brain issues
Risk data corruption (if not architected properly)


# Only Troubleshooting Framework You Need -
Follow this sequence every single time:

Check pod status - What’s the actual state?
Describe the pod - What do the events say?
Check logs - What’s the application reporting?
Verify networking - Can the pod reach what it needs?
Check dependencies - Are secrets, configmaps, and volumes available?
Verify resources - Does the node have capacity?


# Infrastructure & Containers (Linux/K8s)

1. Question: A pod is stuck in CrashLoopBackOff. Walk me through your troubleshooting steps.

Answer: I’d start with kubectl describe pod to check events (OOMKilled, ImagePullBackOff). Then, I’d check kubectl logs --previous to see why the application died, and finally, verify ConfigMaps/Secrets are correctly mounted.

2. Question: How do you monitor the health of a Linux server beyond just CPU and RAM?

Answer: I look at Load Average (relative to CPU cores), I/O Wait (disk bottlenecks), Network Saturation, and Context Switching. High I/O wait often indicates that the Observability stack is hitting disk limits during heavy logging.

3. Question: What is the difference between a Liveness probe and a Readiness probe?

A Liveness probe determines if a container needs to be restarted. 
A Readiness probe determines if the container is ready to accept traffic. If an ES node is joining a cluster, it shouldn't be "Ready" until its shards are initialized.

4. Question: How does Prometheus scrape metrics from a Kubernetes cluster?

Answer: It uses "Service Discovery." Prometheus queries the K8s API to find pods with specific annotations (e.g., prometheus.io/scrape: "true") and then pulls metrics from their /metrics endpoint via HTTP.

5. Question: If a Linux process is using 100% CPU, how do you find which thread is responsible?

Answer: I would use top -H -p [PID] or htop. This shows the individual threads. For Java-based tools like Elasticsearch, I’d then take a thread dump (jstack) to map that thread ID to a specific code function.


6. Kubernetes cluster CPU consistently 80%.

Scale nodes
Optimize workloads
Enable autoscaling
Review resource requests

