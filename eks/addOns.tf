# This enables the VPC-CNI

resource "aws_eks_addon" "name" {
  depends_on   = [aws_eks_cluster.example]
  cluster_name = aws-eks_cluster.example.name
  addon_name   = "vpc-cni"
  configuration_values = jsonencode({
    "enableNetworkpolicy" = "true"
  })
}