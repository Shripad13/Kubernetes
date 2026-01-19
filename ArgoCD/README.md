# Foe executing the argo.yaml - 
1. Create a namespace for argo-cd
   $ kubectl create namespace argocd
2. Apply the argo.yaml file
   $ kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml


$ kubectl get all -n argocd
$ kubectl get svc
$ kubectl get svc -n argocd
$ nslookup <EXTERNAL-IP>        (It takes some time to get the external IP)

while true; do nslookup <EXTERNAL-IP>; sleep 0.5; done

$ kubectl get secrets -n argocd  (during login of argoCD UI it requires)

$ kubectl get secret argocd-initial-admin-secret -n argocd -o yaml

password will be in base64 format, decode it using below command -
$ echo '<base64-encoded-password>' | base64 --decode

username : admin
password : <decoded-password>


3. Access the ArgoCD UI
   - Port forward the ArgoCD server service to localhost
     $ kubectl port-forward svc/argocd-server -n argocd 8080:443
   - Open your web browser and navigate to https://localhost:8080
   - Login with the default username "admin" and the password is the name of the ArgoCD server pod
     $ kubectl get pods -n argocd -l app.kubernetes.io/name=argocd-server -o name | cut -d'/' -f 2


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
