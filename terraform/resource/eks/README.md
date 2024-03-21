# How to export the cluster .kube/config file?
1- Login in AWS using the CLI first with your secret and access key

2- Run the below command to export the .kube/config file in your home directory

aws eks update-kubeconfig --name [cluster_name] --region [region]

Example: aws eks update-kubeconfig --name my-eks-cluster --region us-east-1

# Resource: aws_iam_role
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role

# Resource: aws_iam_role_policy_attachment
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment

# Resource: aws_eks_cluster
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/eks_cluster

# setup Kubernetes using terraform (on AWS)
Create a VPC
Create extra subnet for kubernetes
Create EC2 instance
Create Security Groups for kubernetes
Create IAM roles
Create IAM policies
Attach Roles
Create EKS Cluster
Create Node Group