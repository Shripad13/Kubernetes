# Kubernetes

WE ARE NOT IN INTERST OF ENGINEERING THE K8S,  WE ARE IN INTEREST OF ENGINEERING THE APPLICATION.

> KUBERNETES is top-notch Container Orchestration Tool.
K8s is Opensource with CNCF

In K8s, it will be shared storage across instances & containers in that & will have common network.
That reduces the latency exponentailly between containers in one pod.

Group of resources delivers needed output & acts as single resource/entity.
High Availability is the main Motto.


> We should have a k8s cluster provisioned for learning k8s
> In k8s, Manifest file is always source of truth, If you run through the comamnd that is only temporary.

# Other Container Orchestration Solutions -
1. K8s - Community based support/ opensource edition, will not get support from any company.
2. OpenShift - On Premise based k8  (support will be offered by RedHat)
3. Rancher
4. Tanzua (Product from VMWare)
5. Docker Swarm - not even in race of these.

Mostly cloud based companied will use Cloud managed services - EKS, GKE, AKS
If Servers on-prem then will use Rancher/ Tanzua

Graduated means Product is certified
Incubating means Product is still in developing phase.
Sandbox meas Product which are used for demo/ Experimental purpose.

## Why K8s?
1. Backed by CNCF
2. Lot of Community support
3. It is an Opensource & freeware (No need to pay anyone)
4. Better than Docker Swarm, solves certain problems with Network & storage.
5. Cloud Native



## Managing k8s cluster by using EC2/ On-Prem Instances.
1. Create a Instance (t3.small or meduim with 30 GB)
2. Install RUn time (Podman docker)
3. Install k8s ()
4. Enroll the nodes 
5. Install kubectl (k8 client ot connect to the cluster)


## How Manual Installation of Kubernetes works? (How to provision a K8s CLuster)
1. On linux , we need to install docker or container run time (containerD is preferred) / Podman docker.
2. Install kuberetes solution on all the nodes and designate one of the Node as a Master & rest of the nodes are the worker nodes.
3. Once you Install Kubernetes on the master node, It offers you a TOKEN , using that TOKEN other nodes will be connected and acts as a worker nodes.
4. Ensure Kubelet is installed on all the worker nodes (Kubelet is the local leader for each worker nodes).
5. Your workloads will be running on the worker nodes.

## Using Managed Servcies from Cloud we can provision a K8s CLuster
AWS - EKS (Preferred)
GCP - GKE (Google K8s Engine)
AZure - AKS (Azure k8s service)
All 3 are not free tier

## Use a Learning Environment : Minikube
1. Create an EC2 Instance (t3.small or medium with 30 GB & expand the /var & /root-vol directories)
2. Install Minikube on it.

Most of the info can be availed from "kubernetes.io"

> Latest Kubernetes Version - 1.34 (November 2025)

Always say in interview 2 versions behind, we keep our k8 2 verison behind as per org policy

Kubectl - k8's client used to connect to k8 cluster which is installed on the computer/server where we are connecting.

Kubelet - this is a local leader of worker node which is going to report node & worker status to the Master node.

kubeadm - To set up on On-Prem servers.

## Kube API server
Kube API server port is 6443
The Kube API Server is the central management component of Kubernetes. It acts as the front-end of the Kubernetes control plane and is the single entry point for all administrative tasks.

## How it works in the Kubernetes architecture:
You run -  kubectl apply -f pod.yaml

kubectl sends the request to the API server.
API server:
1.Authenticates and authorizes the request.
2.Validates the pod spec.
3.Writes the new pod definition to etcd.
4.Notifies the kube-scheduler to place the pod.
5.Notifies the kubelet on the chosen node to create the pod.


> Kube API Server: Central management component; only component that communicates with etcd.
> etcd databse: Stores all cluster data and configurations.
> Controller Manager: Ensures the desired state of the cluster is maintained.
> Scheduler: Assigns Pods to nodes based on resource availability.
> Worker Nodes: Execute the workloads (Pods) and provide necessary resources.

# Worker/ Data Plane Components:
1. Kubelet            (Runs on each & every node)
2. Container Runtime  (Docker/Podman)

# How can we connect to Kubernetes cluster
1. kubecl (cli way of accessing the cluster, This is the most preferred way of use)
2. non-cli  (K9s)
3. K9's GUI (Octant)


# Kubernetes Architecture ########

Master Component also called as control plane 
One Kubernetes cluster consist of one master Node with multiple Worker/Data plane nodes along with Shared Storage.

k8's will have one master Node with multiple Worker/Data plane nodes along with Shared Storage.
In k8s, we have lot of resources & around all Pod is the smallest computing resource !!!

NodePool is a group of nodes of similar type.
One Cluster will have no. of NodePools.


## What is kube context file?
1. This is a file that resides on your server under profile after you authenticate to the cluster ~/.kube/config
2. This has the token/ auth info to connect to the cluster.
3. This also has the option to tell on which cluster your commands are supposed to be executed( current cluster)

## How to Create k8s resources?
1. Either using Imperative approach (directly running the resource commands & its not recommended as you cannot version control it)
  $ kubectl run NAME --image=image

2. Declarative approach : Writing manifest files using YAML & then applying this, this is the most recommended as we can version control it.
  $ kubectl create -f fileName.yml (This just creates & cannot be used with resources if they are in place: not recommended)
  $ kubectl apply -f fileName.yml (This creates the resources mentioned in the manifest file if they are not in place, if they are already in place, it updates the resources with the latest values that are mentioned in the yml files)


## What is a Pod in K8s?

SYntax - kubectl verb resources
ex- kubectl get pods
    kubectl describe resources  

In k8s you dont run container, you run POD.
Pod has a ability to run more than one container.
POD contains the container.

In Projects, they host 2 Master Nodes, it will help in case of one fails.

A Pod is group of one or more containers with shared Storage & Network resources.  & a specification for how to run the containers.
K8's has Shared Network & Shared Storage solved between the pods which resolved critical problems.

K8's runs the applications in the form of pods, pod is nothing but wrapper to the containers, 
you can run n number of containers within the pod , it offers a single network & storage & going to solve problems of share n/w & storage.

K8's is all about API's
Each & every resource would be under a spcific API.
K8's offers lots of varities of resources.

kubectl api-version

## What is the purpose if Pod?
POD is used to run a container, pod is just a wrapper to containers.
Issue comes up with container not with a Pod.
Wrapper is a script that invoke other scripts.
Here compute resource is container not a Pod.
A pod  can have more than one container.
BUt all the containers in the pod will have same Network & same Storage.


# Important use case on kubernetes cluster !!!
On k8. resources can be utilized very efficiently

1. If you have a k8 cluster, this can be logically provisioned in to multiple spaces & can be delegated into multiple teams.
2. you can host, QA, DEV, SIT enviropnments in a single cluster without having interference to each other.

This can be achieved by using a namspaces.

Namespace is a virtual boundary.

Bydefault on k8 cluster, resources in one namespace can communicate with other pods in other namespaces, however we can control the behaviour if we wish to restrict, using a policy called as Network Policy.

> On k8's cluster , we have these namespaces to host  different resources.

kubectl get namespace

kube-system [control plane components are hosted on this namespace]
kube-public [this is mostly empty by default]
default [k8's resources will be hosted on the default namepspace]

# ConfigMap
Whenever you have a set of properties or variables that needs to be supplied across the components of k8, then rather supplying manually, we tend to create a resource called as "ConfigMap" and we inject this ConfigMap in to the pods

# How to list the supported resources in k8?
 $ kubectl api-resources

# How to list the supported api versions in k8?

 $ kubectl api-versions

# How to see cluster info ?
 $ kubectl cluster-info
# How to start minikube (once you shutdown machine, you need to run this for minikube to start)
 $ minikube start --force

# shows logs of container
 $ kubectl logs-f <container>

# to see logs every 3 sec
$ kubectl get pods -w or $ kubectl get pods --watch

# To get the manifest yml file on CLI of deployed k8s resources
$ kubectl get resourceType resourceName -o yaml
$ kubectl get pod nginx-pod -o yaml
it will show default properties as well

# How to validate manifest file without deploying to cluster
$ kubectl apply -f manifest.yml --dry-run=server
 (this tells whether resource is valid & can be deployed or not without really deploying)

 $ kubectl apply -f manifest.yml --dry-run=client (this will only be validated by the client not byt the api-server)


########  NAMESPACE ########

 ## what is NAMESPACE in k8s & what are its default namespace, where our resources are going to be created bydefault?

> why Namespaces are required?
Creating a multiple k8 cluster is not a viable option bcoz its a costly thing, so we create a big cluster in that resources created by multiple teams should not be isolated, allof them belong to same project but operated by different teams, easiest way is creates a NAMESPACES & delegate access to each team to access required namspaces.
Ex- Payment team can use  payment NS, Cart team can use cart NS & so on.

Fundamental concept of the Namespaces is to isolate the resource.


Namespaces in k8 are a way to divide & manage resources in a cluster by creating isolated env for different users or projects.
Using, we can isolate the resources belongs to different & this is to make sure one team cannot access other teams resources.
Also we can ensure , that one namaspace can use only x CPU & Y Memory & can define these limits.


K8s Comes up with 3 default namespaces:

Depending on the version of k8, you might see the kube-node-lease namaspace.

1. default - The default namespace for objects that dont have a specified namespace. This is the namespace thats referenced by default for every k8 command.

2. kube-system - Used for k8s components such as kube-dns & kube-proxy, api-server, controller manager, scheduler.
3. kube-public - Used for public resources, such as info needed to communicate with the k8s API.

## how to see all the resources of a specific namespace?
 $ kubectl get namespace 
 $ kubectl get all 
 $ kubectl all -n <kube-system> (for particular namespace)

$ kubectl get all            ----> To see all resources in the default namespace
$ kubectl get all -n expense ----> To see all resources in the 'expense' namespace 
$ kubectl get all -A         ----> Shows all resources across all Namespaces


## K8 resources scope can either be nameSpace or Cluster based
  1. pods are namespace
  2. node are cluster resources

## How do we know whether a resource scope is cluster or namespace?
 $ kubectl api-resources
 in output you can check NAMESPACES column true or false?


## We dont create pods in k8 directly? Then how?
  We use SETS:
   There are 4 types of sets & these sets will create the  PODS in k8, Bcoz of the advantages to maintain the replica count of the pods.
     1. REPLICA SET
     2. DEPLOYMENT SET
     3. DAEMON SET
     4. STATEFUL SET

1. REPLICA SET-
    1. This will ensure the mentioned number of pods are running all the time.
    2. Even if we/system  deletes the pod, immediately the mentioned numbers of pods will automatically be created.
    3. Using replica-set, we cannot update the existing running pods from X to Y version,Only replicapset will be configured but its not going to impact the pods. But new pods that are going to be provisioned by this replica-set will have the image that will update wth new version.
    4. We only use replica-set just to make sure the committed no. of pods are running all the time or not.
    5. If you want to support the version update to the pods then we need to use another type of SET called as DEPLOYMENT SET.

How to scale a replicaset manually?
 $ kubectl scake rs rsName --replica=x

** Lables & Selctors   -
    Lables & Selctors helps in enabling establishment between controller & resources.

2. DEPLOYMENT SET -
    Deployment set is a wrapper to Replicaset
     1. This ensure the mentioned no. of pods are running all the time.
     2. Deployment set helps in moving the pods from one version to another version     (old version pods will be deleted & new pods will be coming very fast)
     3. Deployment set again create a replica-set in the backend (behind the hoods)

 kubectl get deployments         ----> To see all deployments in the default namespace
 kubectl describe deployment nginx-deployment  ----> To describe a particular deployment

 ** By default, deployment updates goes by deployment type of ROLLING UPDATE, which take down the old version by creating a new pods with the NEW Verison, we can also define the Rolling update percentage as well. (ZERO to none downtime)

 ** If you are not interested, we can also go with RECREATE STRATEGY in Deployment, whenever a new version comes up, all the old versions will be deleted at a time & new one will be created (There would be some Downtime)

 This type of deployment called as ROLLING update DEPLOYMENT which is default deployment strategy in kubernetes.


---- ROLLING update ---->
 pod v1 ---> pod v2
 pod v1 ---> pod v2
 pod v1 ---> pod v2
 ---- ROLLING update ---->

 It happens one by one within fractions of seconds, so that there is no downtime for the application.     
 Deployment in the backend is creating a new replica-set & then scaling down the old replica-set.


# Deployment Types -
  1. Rolling Update
  2. Recreate 
  3. Blue Green

## STATEFUL set
 Stateful set ensure all the created pods will be having a disk attached to it & at the same time this is mostly used to host the DB or Storage based workloads.
 
 Pods created by the stateful set will have a number associated with it.
 pod-0, pod-1, pod-2, pod-3, pod-4           

 They will be created in the order & at the time, new pod of the set will only be coming up after the creation of the pod successfully.
 Even if you scale down a stateful set with 5 pods, the first pod to be deleted is pod-4
 very less no. of times, we would scale down (99 % of the time we would never scale down)                                           


### What is CLoud Native K8s means?
  A product that is designed to work on cloud but is also capable to run on-prem but this yields all the promised features with ease when they are on cloud.
 Ex - If you want to use stateful set- 
        1. If you are on-prem, then we are responsible for provisioning the underlying storage disk for the statefulset.
        2. Using Persistent Volume & Persistent Volume claim (PV / PVC)
        3. If you are on CLOUD, cloud provider offers STORAGE CLASS, this automatically provisions the underlying disk for the pods of the stateful set.


  $ kubectl get nodes
  $ kubectl get nodes -o wide       ---> you will get Container IP,VERSION, ROLES      


  If you have n no. of containers in single pod, pod offers a single networking namespace. 

  ## How to connect to these workloads?
    1. Do pods have IP ? Yes
    2. Do containers with in the pods have IP address? No
    3. How to connect to them?


## ConfigMap in K8s
    1. ConfigMap is a wrapper to hold a bunch of env variables that can be supllied like packed entity to the pod.


##  SERVICES -
Lets say if we have n no. of pods and each have different IP's for that replica-set is just a wrapper for pods.
If my Backend wants to connect to frontend & DB want to connect to Backend, which port will be used in that case?
This is where SERVICES comes into picture.

This is as abstract that helps in connecting to pods & this load balances the requests
> Expose an application running in your cluster behind a single outward-facing endpoint, even when the workload is split across multiple backends.
> In Kubernetes, a Service is a method for exposing a network application that is running as one or more Pods in your cluster.


## Types of Services in Kubernetes- 
1. Cluster IP (imp)   - This type of service is only accessible with in the cluster
2. Load Balancer (imp)- This is to expose something to Internet, typically any service that needs to be exposed to internet.
3. Node Port     - This is also something to allow access from the internet, but using the node port
4. External Name (Alias for CNAME)

If you dont mention the service type while creating the service, it defaults to clusterip (which is a good option)

kc get pods -o wide ---> get the pods with service
kubectl describe svc <svc-name> -- get the Endpoints so that get to know which IP's are assigned for this service

Imp :
    1. When we are trying to connect to any services from any nameSpace, by default the k8 will look for the service the nameSpace from where we are making the call.
      Ex- nginx-svc is in default nameSpace, exp-pod is in expense nameSpace.
        Now if you want to make a call from expense-nameSpace to service in other nameSpace you need to call the service by using FQDN.
        
        syntax of FQDN of svc: svcName.nameSpace.svc.cluster.local
            Ex of FQDN of svc: nginx-svc.default.svc.cluster.local


## External Name:
    This is to create an alias name for a biggerNames. Its like a craeting a CNAME record.
     Ex: My service name is nginx-svc in default nameSpace & if this has to be called from other nameSpaces, here is the FQDN to use.
         "nginx-svc.default.svc.cluster.local"
    
    If you create an external name in other nameSpace, then you will call the above svc with just the short name.



## Job Resources in K8s-
1. You want some task should be executed at some time


## CronJob
A CronJob creates Jobs on a repeating schedule.
Jobs creates the pod.

CronJob is meant for performing regular scheduled actions such as backups, report generation, and so on. One CronJob object is like one line of a crontab (cron table) file on a Unix system. It runs a Job periodically on a given schedule, written in Cron format.


## We should neither hardcode the credentials on Manifest files nor on Vault, bcoz when if user has access to bash/shell, they still can access the credentials, So in K8s we have Role-Based Access Control (RBAC). 


## Headless Service in Kubernetes- 
A headless Service allows a client to connect to whichever Pod it prefers, directly. Services that are headless don't configure routes and packet forwarding using virtual IP addresses and proxies; instead, headless Services report the endpoint IP addresses of the individual pods via internal DNS records, served through the cluster's DNS service. 
To define a headless Service, you make a Service with .spec.type set to ClusterIP (which is also the default for type), and you additionally set .spec.clusterIP to None.

The string value None is a special case and is not the same as leaving the .spec.clusterIP field unset.

## How do we control what can be maximum  resources ( CPU & Memory) that can consumed by containers with in the pod?

* How to define, what are the minimum CPU & Memory needed for the container in the pods to start?
  if the minimum needed resources mentioned in the pod are not available on the node, then that Pod wont be scheduled; Instead it will go to pending state.


* How to define, what are the minimum CPU & Memory needed for the container that it can use?
  If we define the limits for the resources, whenever container reaches the limits in the pod, Pod goes for a restart.

How to deal this restart, that where Resource Mangement comes in to picture.

## Resource Mangement for Pods and Containers -

When you specify the resource REQUEST for containers in a Pod, the kube-scheduler uses this information to decide which node to place the Pod on. When you specify a resource LIMIT for a container, the kubelet enforces those limits so that the running container is not allowed to use more of that resource than the limit you set. The kubelet also reserves at least the request amount of that system resource specifically for that container to use.

> Requests and limits are not for pods, Requests and limits are not for per container within the pod.
> Requests and limits are at container level of the pod, if we have 3 containers in a pod, then we need to mention limits & requests for both the containers.

IMP: Only Requests are guranteed, Limits are not gurranteed.

Request is the mentioned 'x' amount of resource can be used for the container, where as Limit is the mentioned 'Y'Max amount of resource till container can go.

## Always limits > requests


# How to check the resource utilization of Pods?
For this you need to install METRICS_SERVER, then it collects the metrics & shows us.

# How to check the resource utilization of Nodes?


Page size in DB - what is the maximum data a process can utilized.

## Quotas in Kubernetes?
ResourceQuotas work like this:
  1. Defining limits saying that my namespace can have a maximum of 100 pods.
  2. Namespace-x can have a maximum of 16 GB Memory utlization only.
  3. A maximum of 100 secrets can be created in a namespace.
  4. If creating or updating a resource violates a quota constraint, the request will fail with HTTP status code 403 Forbidden. With a message explaining the constraint that would have been violated.

Quotas majorly comes up in a efficient & a shared cluster where namespaces are extensively used.

When several users or teams share a cluster with a fixed number of nodes, there is a concern that one team could use more than its fair share of resources.

Resource quotas are a tool for administrators to address this concern.
* When quotas are defined in a namespace, pods/deployments should have limts & requests defined if not, resources wont br created.

kubectl get quota
kubectl get quota -n <namespace>
kubectl get events -n <namespace> 

## Probes (Health Check in K8s)
How do you know application is healthy or not?

* We can scale the pods of the deployment either by CPU or Memory or by custom Metric.

> For every application there will be a health check endpoints
> By this command you can get your health check of application running on server "curl localhost/health"



### Scaling -


$ kubectl get hpa
$ kubectl get vpa

## How EKS Cluster Autoscaling Works?
  1. Just like how pods HPA works, likewise with in the min & max values of the EKS Cluster Nodepool, the number of nodes would upsized & downsize automatically.
  2. what will happen if the pod that you are trying to scale is a big pod & curremt pod cannot accomodate? (pod goes to pending state & that craetes an event to add one more node in the cluster node pool) 

> Whenever pods go for unschedule state, autoscalar should create another node
> We need to deploy auto-scalar & for this auto-scalar we need to attach the IAM Roles (OIDC)

######  Scheduling 
Scheduling would be done by Scheduler on the control plane of kubernetes
Scheduler by default Schedules the pods on the nodes as per availability.

What if you dont want pods to be Scheduled on a specific set of nodes.
What if I want my pods of deployment x & y should be deployed on the same node.
What if my pods of deploymemt x & y should never ever to be deployed on the same node.
What if I want my pods should be deployed on the noedes at a balanced aspect per zone to keep high-availability.
What if you've pods of important applications vs pods of low priority applications & would like to make sure, pods of high-priority should be taken into consideration first.
What if low priority pods are already running & if you schedule high priority jobs & if resources are not available to accomodate high priority pods, low priority should be evicted from the node? Pod priority & Pre-emption cmes up.



## VPA: Vertical   Pod Autoscaling ("scaling up"): (Adding resources to the same instance)
VPA ex - updating instance from t3.micro  to t3.medium invloves downtime 
In any cloud, scaling a resource vertically always involves DOWNTIME.
Vertical scaing is always Costly.

Vertical scaling requires taking a machine offline to:
add CPU
increase RAM
upgrade OS/hardware

Vertical Pod Autoscaler (VPA) is a Kubernetes feature that automates the process of adjusting resource limits for containers in pods. Unlike Horizontal Pod Autoscaler (HPA), which scales the number of replicas of a pod, VPA scales the resources allocated to a pod's containers. It adjusts the resource requests and limits for each container based on its actual usage.


  1. This helps in adding resources to the pod by taking down the pod that experiencing resources stress with a new pod with more resources.
  2. VPA always involves downtime
  3. VPA is additional feature ,we need to enable vpa-admission-controller on eks cluster.
Search on Goggle to perform the installation. 

VPA Operates in 2 modes:
  * Manual Mode -   (Pods will be upsized & downsized automatically: but involves downtime)
  * Atomatic Mode - (When you enable in autoMode, you just get suggestions) 


Both HPA & VPA CANNOT be used for same deployments.

* Why servers with high CPU & Memory are costly when compare in proportional to small servers.
Size of the server increases cost will also increases.


* HPA: Horizontal Pod Autoscaling ("scaling out")- involves no DOWNTIME.

HPA only work when you mention resources requests & limits in manifest file.

Horizontal scaling means adding more machines/instances instead of upgrading a single one.

typically involves less downtime because new machines can be added to the system and begin sharing the workload while the existing servers remain online
1. You add capacity without stopping the system
2. Load balancers make it seamless
A load balancer can route traffic to:
existing healthy instances
newly added instances once they’re ready

⚠️ Horizontal scaling is not inherently cheaper or downtime-free. It depends on architecture:
stateless services = easy
stateful/monolithic apps = harder and possibly costly to redesign
distributed systems need more ops complexity

✅ Why horizontal scaling is often less costly

Not always, but generally:

1. Commodity hardware is cheaper
Horizontal scaling uses multiple standard/low-cost servers, instead of one extremely powerful high-end machine.

2. Better cost-to-performance ratio
A single high-capacity machine has:
exponential cost increase
diminishing performance returns
Example:
A machine with 2× performance may cost 5× as much.

3. Cloud pricing favors scaling out
Cloud vendors charge:
lower cost for many small instances
higher cost for few large instances
Why? Specialized high-memory/high-CPU machines are premium.

4. Avoids catastrophic single-point failure
If a single giant server fails, the whole system goes down → expensive recovery.
A cluster of small servers losing 1 node = minor issue.

5. Enables auto-scaling
You can automatically add/remove instances based on load.
You only pay for needed capacity → big savings.


## Role Based Acccess Control
Role-Based Access Control (RBAC) is a method of controlling access to Kubernetes resources based on the roles assigned to users or groups. 
RBAC involves creating roles and binding them to users or groups to control access to Kubernetes resources. 
Roles are defined as a set of rules that determine what actions can be performed on specific resources. 
By assigning roles to users or groups, access to Kubernetes resources can be restricted or granted based on the permissions defined in the role. 
RBAC helps ensure the security and integrity of Kubernetes clusters by limiting access to authorized users and groups.


Kubernetes RBAC is a key security control to ensure that cluster users and workloads have only the access to resources required to execute their roles. It is important to ensure that, when designing permissions for cluster users, the cluster administrator understands the areas where privilege escalation could occur, to reduce the risk of excessive access leading to security incidents.

$ kubectl get roles
$ kubectl get roles -A      ----> It searches in all NameSpaces of EKS cluster

## What are the default roles that are available in the cluster?
Points to be noeted:
  1. Just like on linux how you create users & delegate permissions to them either directly or by groups, we can also do the same thing on k8s using k8s users & groups.
  2. you can create your roles, perform binding (adding user to the role)

  Kubernetes uses authorization, not authentication (username & password)
    1. If we create a user, he dont present himself with username & password, instead a token

# What is a service account in k8s?
A service account in k8s is a non-human identity that allows applications to run workloads in k8s cluster.
A service account in Kubernetes provides an identity for processes running inside a pod, allowing them to interact with the Kubernetes API. 
These accounts are used by applications to authenticate to the cluster and are distinct from user accounts, which are for human users. 
By assigning a service account to a pod, you can control what permissions that pod has within the cluster, which is managed using Role-Based Access Control (RBAC).     

# Service Account (sa):
Just like how we ise IAM role to gain access to a non-human resource on AWS, similarly we use Service Account on k8s to let needed roles aligned to k8 workloads.

$ kubectl get sa
$ kubectl describe sa  default

Each & every sa will have token, if that is not available we can generate a token & associate.

$ kubectl create token sample            (Creates a token for ServiceAccount "sample")

Using the above token , we will connect to the cluster (lets create a user account on your linux machine)
We are using a token generated on the system & using this we are attempting to connect to the cluster

```
$ kubectl get nodes
  Error from server (Forbidden)
```

# Roles in k8s are of 2 types:
 1. Roles: Scope is namespace: that you means you create at namespace & thats limited only to the namespace like pod, configmap, deployment.
 2. Cluster Role: scope is entire cluster: you can give access to create a cluster roles, change cluster policies.



## Where the logs of k8s cluster are shipped?
  1. api-server, scheduler, controller logs can be shipped to a service in AWS called as CLoudWatch.
  2. By default you dont see them enabled, you need to explicitly enable it.
  3. Once you enable it, you can view  them on CLoudWatch .


Concepts -
All the below topics are to make sure how & where scheduling should be done by the scheduler
    1. Taints
    2. Tolerations
    3. Node Selectors
    4. Pod Affinity
    5. Pod Antifinity
    6. Topology Constraints
    7. Pod Priority
    8. Preemption

Use cases -
    1. you have 3 types of nodes on the cluster that has SSD Disks, HDD disks, Flash Drives    



How to see the labels ?
$ kubectl get nodes -o wide --show-labels

How to label the nodes?
$ kubectl label nodes ip-172-31-39-2.ec2.internal disktype=ssd
$ kubectl label nodes ip-172-31-39-2.ec2.internal disktype=flashdrive

Using nodeselector, we can define the where to schedule the pods?
How can we make sure that pods should not be schduled on the nodes of our choice?

Taints & Tolerations are used in k8s to restrict or allow pods to be scheduled on certain nodes based on labels.
When you taint(for memorization we call it to paint) the pod, it will restrict the pod to schedule on nodes.

Taints - 
  Taint is a feature that allows scheduler not to schedule pods on the nodes that has taints.
  Only the pods that has tolerations to that taint can be allowed to be scheduled on the tainted node.

Taints can be operated in 3 modes:
  1. NoExecte         : Pods that do not tolerate the taint are evicted immediately.
  2. NoSchedule       : pods will only be scheduled on the tainted nodes if the pod has tolerations; if not scheduler wont schedule the pod
  3. PreferNoSchedule : PreferNoSchedule is "preference" or "soft" version of NoSchedule. The control plane will try to avoid placing a pod that does not tolerate the taint on the node, but it is not guranteed. 


$ kubectl taint nodes <nodeName> app=expense:NoSchedule  -----> to make a taint to node
Workloads going to be scheduled on top of this node.

$ kubectl describe node <nodeName>                       ------ > to list the taints

## Can workloads/pods be scheduled on the master node of EKS Cluster or not?
No, workloads cannot be scheduled because they are managed by AWS and not part of your node pool.
The control plane (master nodes) in EKS is fully managed by AWS and is not exposed as part of your cluster. You do not have access to these nodes, and they are dedicated to running Kubernetes components like the API server, etcd, and controller manager.
All your workloads (Pods, Deployments, etc.) run on worker nodes (EC2 instances or Fargate profiles) that you manage or configure.

In openshift, we can scheduled pods on the master node , bcoz you will be the responsible for managing the Master & worker nodes.

# Whenever we are taking maintainance of the custer (Updatign frm one version to other version)

1.29.3 (MajorVersion.MinorVersio.servicePack)
We can only upgrade from one minor version to other minor version (1.29.3 to 1.30.1 to 1.31.0)
But we can move from one servicePack to other servicePack without any dependency

In the maintainance window, typically first master will be updated & then worker nodes will be upgraded.
In the unmanaged/On-Premise k8s cluster, if you wish to do maintainance on the node, then we first mark that node in maintainance using an option called as "cordon". Once you cordon the node, new workloads wont be scheduled on it that turns to NotReady state.

$ kubectl get nodes -o wide 
$ kubectl cordon node <nodeName>   ----> TO cordon the node
$ kubectl get nodes -o wide 
$ kubectl get pods

Taint the nodes at nodepool rather than tainting the nodes at pod

1. First we cordon the nodes (this disabled the scheduled, existing workloads will run as is )
2. Next is to drain the node, (existing workloads as per graceful internal, they will run & will be evicted & will be scheduled as per the expecatations on the other nodes)
$ kubectl drain <nodeName> --grace-period=30 

3. Once maintainance is done, then we can uncordon the node.
$ kubectl uncordon <nodeName>

## how to get rid/remove the taint on nodes? (There is NO untaint command)

$ kubectl taint nodes <nodeName> app-

## Topology Constraints --

EKS Cluster should be fault tolerant means deployments will be done on 3 zones (ex- us-east1a, us-east1b, us-east1c)
it ensures even distribution of pods across a cluster's topology.
Always keep odd number zones like 3,5,7...

> you can setup EKS Cluster across Zonal not a regional
you need to setup 2 EKS cluster on 2 different regions & use Global Load Balancer for balancing the load.

         Global Load Balancer
Regional LB1              Regional LB2              
EKS Cluster1               EKS CLuster2


> Key Points:
```
    1) The maximum difference in number of pods between any two topology domains. The default is 1, and you cannot specify a value of 0.
    2) The key of a node label. Nodes with this key and identical value are considered to be in the same topology.
    3) How to handle a pod if it does not satisfy the spread constraint. The default is DoNotSchedule, which tells the scheduler not to schedule the pod. Set to ScheduleAnyway to still schedule the pod, but the scheduler prioritizes honoring the skew to not make the cluster more imbalanced.
    4) Pods that match this label selector are counted and recognized as a group when spreading to satisfy the constraint. Be sure to specify a label selector, otherwise no pods can be matched.
    5) Be sure that this Pod spec also sets its labels to match this label selector if you want it to be counted properly in the future.
    6) A list of pod label keys to select which pods to calculate spreading over.
```    


## Pod Priorities -
Pod priorities in Kubernetes determine the order in which pods are scheduled on nodes when there are competing demands for resources.

1. Node Selector
Node Selector is the simplest scheduling mechanism. It allows you to specify a key-value pair, and Kubernetes schedules pods only on nodes with matching labels.
This deployment will schedule pods only on nodes labeled 

2. Node Affinity
Node Affinity provides advanced scheduling options compared to Node Selector. It allows you to use logical operators like In, NotIn, Exists, and more. You can define both hard and soft constraints.
Pods will only be scheduled on nodes labeled 
Pods prefer nodes labeled color=yellow but can still run on other nodes if such nodes are unavailable.

3. Pod Affinity
Pod Affinity allows you to schedule pods closer to other pods with specific labels, improving inter-pod communication.
Pods will be scheduled on the same node or close to other pods labeled color=blue.

4. Node Anti-affinity
Node Anti-affinity ensures that pods do not run on certain nodes.
Pods will avoid nodes labeled color=yellow.

5. Pod Anti-affinity
Pod Anti-affinity ensures that pods are not scheduled near other pods with specific labels.
Pods will avoid being scheduled on the same node as other pods labeled color=green.


## Priority Class - 
kubectl get priorityclass


## we can also define the kubelet configuration, to define when to evict the pods.

Sample kubelet config to evict thr pods from nodes if fits a left woth 500Mib memory.

'''

apiVersion: kubelet.config.k8s.io/v1betal
kind: KubeleteConfiguration
evictionHard:
  memory.available: "500Mi"
  evictionMinimumReclaim:
    memory.available: "oMi"

'''


## Cluster Autoscalar -
1. Cluster Autoscalar listens to the node stress events & would be autoscale the nodes in the nodepool as per the max cap values.
2. Cluster Autoscalar is a deployment that has to go to kube-system.
3. Pods of the Cluster Autoscalar Deployment should have the needed IAM roles attached to launch the new nodes in the Cluster.
4. We will also learn a concept in IAM called OIDC Provider ( Pods on the k8s )


## Integrating the K8s ServiceAccount with IAM role in AWS will give needed power to launch the instnaces.

# Goal: OIDC Integration
  1. To launch k8s workload with service account 
  2. Create OIDC provider on cluster
  3. Create IAM Role that has permissions to launch nodes in eks cluster nodepool.
  4. Binding of IAM Rle with K8-SA can be achieved by using the OIDC.
  5. Then that k8 workload will get the needed roles to launch the nodes in the cluster.


## alias in .bash_profile ##
alias gp="git pull"
alias klf="kubectl logs -f"
alias kaf="kubectl apply -f"
alias  kc="kubectl"
alias kgp="kubectl get pods"
alias kgn="kubectl get nodes"
alias kdp="kubectl describe pod"
alias keit="kubectl exec -it"

> Check the pods status continuously  =====>> kubectl get pods -w      




## ArgoCD - 

1. This is to perform GitOps in k8s cluster.
2. It has reconissance - Continuously checks the git repo (helm charts on github)for any changes in the manifest files.
3. Reconcilation - 
If you made any changes manually on the deployment managed by ArgoCD, ArgoCD controller immediately reverts those changes from the cluster as per the git repo as a source of truth.

           (reconcissance)          (reconcilation)
GitHub Repo  <----->  ArgoCD Controller  <----->  EKS Cluster
     (Helm Charts)                        (Watches for changes)      (Deploys the changes)


## Why ArgoCD?
  1. Deployment tool for k8s.
  2. To have a single pane of glass to manage multiple k8s clusters.
  3. To have a better visibility on what changes are going to be applied to the cluster from git repo.
  4. To have better control on who can apply what changes to the cluster from git repo.

## Where are you going to install ArgoCD?
  1. You can install ArgoCD on any of the k8s cluster that you have access to.
  2. You can also install ArgoCD on a separate k8s cluster that is dedicated for ArgoCD.
  3. You can also install ArgoCD on the same k8s cluster where your applications are running.

## What are the specialities of ArgoCD?
  1. It has a web UI to manage the k8s clusters.
  2. It has a CLI to manage the k8s clusters.
  3. It has a REST API to manage the k8s clusters.
  4. It has a GitOps engine to manage the k8s clusters.
  

ArgoCd can be on same EKS cluster where your applications are running or it can be on a separate EKS cluster.

Usually ArgoCD is installed on a separate EKS cluster where tools are running like Jenkins, Sonarqube, Nexus etc.
Applications are running on a separate EKS cluster.
ArgoCD can manage multiple EKS clusters from a single ArgoCD installation.