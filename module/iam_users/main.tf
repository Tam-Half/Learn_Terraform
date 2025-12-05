# Admin User
resource "aws_iam_user" "admin" {
    name = "admin_user_internship_lpc"
    path = "/"
    tags = {
        department = "admin"
    }
}

# Full Policy 
resource "aws_iam_user_policy_attachment" "admin" {
    user = aws_iam_user.admin.name
    policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess"
}

# Create Access_Private_Key for Admin

# gpg --full-generate-key (Gen gpg)
resource "aws_iam_access_key" "admin" {
    user = aws_iam_user.admin.name
    pgp_key = "keybase:tamhalf"
}

# gpg --full-generate-key (Gen gpg)
resource "aws_iam_user_login_profile" "admin" {
    user = aws_iam_user.admin.name
    pgp_key = "keybase:tamhalf"
}

# Access_private_Key of Admin
# gpg --import privatekey.asc
# echo "VALUE_ENCRYPTED_HERE" | base64 --decode | gpg --decrypt
# Get real password and secretkey
resource "local_file" "private_access_key_admin" {
   content = <<-EOT
User Name,Access Key ID,Encrypted Secret Key,Encrypted Password
${aws_iam_user.admin.name},${aws_iam_access_key.admin.id},${aws_iam_access_key.admin.encrypted_secret},${aws_iam_user_login_profile.admin.encrypted_password}
EOT
    filename = "${path.module}/admin_accesskey.csv"
}

# User Bacsic EC2
resource "aws_iam_group" "devops_group" {
  name = "devops_group_internship"
  path = "/devops/"
}

# resource "aws_iam_policy_attachment" "user_basic" {
#     name = "12312"
#     users = [aws_iam_access_key.admin.id]  
#     roles = []
#     groups = []
#     policy_arn = ""
# }

resource "aws_iam_user" "user_devops_01" {
    name = "devops_user_internship_lpc_01"
    path = "/devops/"
    tags = {
        department = "devops"
    }
}


resource "aws_iam_group_policy" "my_devops_policy" {
  name  = "policy_for_devops"
  group = aws_iam_group.devops_group.name

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = ["ec2:Describe*"]
        Resource = "*"
      },
      {
        Effect = "Deny"
        Action = [
          "ec2:RunInstances",
          "ec2:TerminateInstances",
          "ec2:StopInstances",
          "ec2:RebootInstances",
          "ec2:Delete*"
        ]
        Resource = "*"
      }
    ]
  })
}
resource "aws_iam_group_membership" "devops_membership" {
  name = "devops_membership"
  group = aws_iam_group.devops_group.name
  users = [aws_iam_user.user_devops_01.name]
}




resource "aws_iam_user_login_profile" "user_devops01" {
    user = aws_iam_user.user_devops_01.name
    pgp_key = "keybase:tamhalf"
}

resource "local_file" "private_info_user_devops" {
    content = <<-EOT
User Name,Password
${aws_iam_user.user_devops_01.name},${aws_iam_user_login_profile.user_devops01.encrypted_password}
EOT
    filename = "${path.module}/user_devops_01.csv"
}

