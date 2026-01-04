
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

