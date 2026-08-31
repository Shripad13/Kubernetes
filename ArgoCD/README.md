You can use ArgoCd Documentation for Initial Setup

# For executing the argo.yaml - 
1. Create a namespace for argo-cd
   $ kubectl create namespace argocd
2. Apply the argo.yaml file
   $ kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml


$ kubectl get all -n argocd
$ kubectl get svc
$ kubectl get svc -n argocd
Look for argo-cd NAME which is in ClusterIP
$ kubectl edit svc  argocd-server -n argocd ----> change the ClusterIP to NodePort
$ kubectl get svc -n argocd
$ kubectl get nodes -o wide            -----> Get the External IP

In Security group open the firewall for NodePort for NodePool , In Inbound Rule, allow the port


$ nslookup <EXTERNAL-IP>        (It takes some time to get the external IP)

while true; do nslookup <EXTERNAL-IP>; sleep 0.5; done

$ kubectl get secrets -n argocd  (during login of argoCD UI it requires)

$ kubectl get secret argocd-initial-admin-secret -n argocd -o yaml
$ kubectl edit secret argocd-initial-admin-secret -n argocd 

password will be in base64 format, decode it using below command - ignore percentile
$ echo '<base64-encoded-password>' | base64 --decode

username : admin
password : <decoded-password>


3. Access the ArgoCD UI
   - Port forward the ArgoCD server service to localhost
     $ kubectl port-forward svc/argocd-server -n argocd 8080:443
   - Open your web browser and navigate to https://localhost:8080
   - Login with the default username "admin" and the password is the name of the ArgoCD server pod
     $ kubectl get pods -n argocd -l app.kubernetes.io/name=argocd-server -o name | cut -d'/' -f 2


Bydefault ArgoCD takes 3 mins for reconcilation,so you can update by following command:
 $ kubectl edit cm argocd-cm -n argocd
Add below lines -
 data:
   timeout.reconciliation: 10s


ACR to AKS Authentication for pulling images to AKS 
ImagePullSecrets concept if "get ErrPullImage" 

$ kubectl edit pod <podname>


HEAD - mean most recent commit on the current branch
Path - helm-charts     

DESTINATION - CLuster URL- https://kubernetes.default.svc
Namespace - default

Helm -
VALUES FILES - backend.yaml


# How do you integrate ArgoCD for deployment?
“We integrate Argo CD by installing it in the Kubernetes cluster, connecting it to a Git repository containing manifests or Helm charts, and defining Applications declaratively. CI updates the manifests, and Argo CD automatically syncs the cluster to the desired state using GitOps principles, with auto-sync, self-healing, and rollback capabilities.”

# After pushing image to ECR, how do you configure ArgoCD?
“After pushing the image to ECR, our CI pipeline updates the image tag in the Git repository (YAML/Helm/Kustomize). Argo CD continuously watches Git and automatically syncs the updated manifests to Kubernetes. EKS nodes pull the image from ECR using IAM roles, ensuring secure and automated deployments.”

Code Commit
   ↓
CI Pipeline
   ├─ Build Docker image
   ├─ Push image to AWS ECR
   └─ Update Kubernetes manifests (image tag) in Git
                    ↓
              Argo CD detects Git change
                    ↓
            Syncs deployment to Kubernetes


# How traditional CICD is differs from GitOps CICD?
# Reconcilation in GitOps CICD?
Argo CD polls your Git repository Every 3 Minutes
# How do you optimize the CICD pipeline for faster deployments & areas to identify?
Build - Use caching, parallel builds, and incremental builds to speed up the process.
Test - Run tests in parallel, use test impact analysis to run only relevant tests, and consider using faster test frameworks or mocking external dependencies.
Deployment - Use canary or blue-green deployments to minimize downtime, and automate rollbacks for quick recovery.
Security Scan - Integrate security scanning early in the pipeline, but optimize by running only critical scans on every commit and more comprehensive scans on scheduled runs or before production deployments.
Maven Cache - Use a shared Maven cache to speed up dependency resolution across builds.
Artifact Repository - Use a local artifact repository to speed up artifact retrieval.
Docker Layer Caching - Use Docker layer caching to speed up image builds.
Docker Image Size - Optimize Docker images to reduce build and deployment time. Multistage builds, minimal base images, and removing unnecessary files can help reduce image size and speed up deployments.
Network latency - Optimize network latency by using regional resources and minimizing data transfer between stages.
Overall, focus on parallelization, caching, and automation to optimize the CI/CD pipeline for faster deployments while maintaining quality and security.
