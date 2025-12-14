# Provision Node Group and attaches this to the EKS
resource "aws_eks_node_group" "node {
    depends_on = [aws_eks_addon.vpc_cni] # CNI has to be enables on the cluster first

    for_each = var.node_group

    cluster_name = aws_eks_cluster.main.name
    node_group_name = "b58-eks-np-spot-0"

    node_role_arn  = aws_iam_role.node-example.arn
    subnet_ids = ["subnet-00wcnnnv"]
    instance_types = ["t3.medium"]
    capacity_type = "SPOT"

    scaling_config {
        desired_size = 1 # when the cluster was provisioned this would be nodegroup node count
        max_size = 3     # max number of node that the node-group can scale
        min_size = 1     #When the workloads are really less, his would be the number where nodeGroup
    }

    tags = {
        Environment = "Test"
        project     = "expense"

    }

    lifecycle {
        ignore_changes = [
            tags,
        ]
    }
}"


#