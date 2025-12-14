# What can be improved in the following file: Kubernetes/expense-v1/README.md

1. Most of the code in WET
2. Structure is same, just values are changing
3. If you want to parameterized it, the only value that you can IMAGE

Using K8s Package Manager, we can parameterize the values like IMAGE, REPLICAS, RESOURCES etc., and can create a template out of it. This would help in reusability and easy maintenance.

Popular of k8s package Managers: Helm, Kustomize
HELM is the Very Popular Package Manager, using this we can achieve 100% dry in k8 manifests file & offers single shot deployment of including dependencies.

Just like how Ansible playbooks has their own patterns, like wise HELM charts will also have a structure that we need to follow.

> We can achieve DRY by HELM Charts.

# Helm Chart Structure
1. Helm offers parameterizing the entire manifest
2. Keep the code DRY by eliminating the common patterns
3. Also helps in dealing multiple environments by using values files


# Umbrella HELM Chart
An umbrella chart is a Helm chart that contains other charts as dependencies. This allows you to manage multiple related applications or services as a single unit. Umbrella charts are useful for deploying complex applications that consist of multiple components, each with its own Helm chart.

# Helm Chart Structure
A typical Helm chart has the following structure:

``` plaintext
mychart/       
├── Chart.yaml          # Information about the chart,holds the metadata like chart name,apiVersion,version of chart,description etc.
├── values.yaml        # Here supply all the needed values & name of the values.yaml can be any file like dev.yaml, prod.yaml etc. 
├── charts/            # Directory for dependent charts/ subcharts, charts inside charts.
├── templates/         # Directory for Kubernetes manifest templates
│   ├── deployment.yaml # Template for Deployment resource
│   ├── service.yaml    # Template for Service resource
│   └── ...            # Other resource templates
└── README.md         # Optional README file for the chart
```

# HELM Installation
``` bash
#!/bin/bash
cd /tmp/
curl -L https://get.helm.sh/helm-v3.16.2-linux-amd64.tar.gz 
tar -zxvf helm-v3.16.2-linux-amd64.tar.gz   
mv linux-amd64/helm /usr/local/bin/helm
helm version
```
# HELM Commands
1. To create a new HELM chart    $ helm create <chart-name>
2. To install a HELM chart       $ helm install <chart-name> ./chartLocation -f values.yaml 
3. To list all the releases      $ helm list
4. To upgrade a release          $ helm upgrade <release-name> ./chartLocation -f values.yaml
you cannot run the install command again for the same release & if there any chnage in the values, you go with upgrade command
5. To uninstall a release        $ helm uninstall <release-name>