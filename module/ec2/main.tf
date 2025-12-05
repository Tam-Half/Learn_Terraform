resource "aws_instance" "node_woker" {

  count = 2 
  ami  = var.aws_ami_id
  instance_type = var.aws_instance_type
  associate_public_ip_address = true
  key_name = var.key_name
  subnet_id = var.public_subnet[count.index]

  vpc_security_group_ids = [aws_security_group.ec2_sg.id]

  # add role eks_woker_node
  iam_instance_profile = var.instance_profile
   
user_data = <<-EOF
#!/bin/bash
/etc/eks/bootstrap.sh ${var.aws_eks_cluster} \
  --apiserver-endpoint "${var.aws_eks_cluster_endponit}" \
  --b64-cluster-ca "${var.aws_eks_cluster_auth}"
EOF

  tags = {
    Name = "${var.aws_instance_name}-${count.index}"
  }
}
  