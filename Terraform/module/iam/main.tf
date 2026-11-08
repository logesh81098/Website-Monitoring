################################################################################################################################
#                                               IAM Role 
################################################################################################################################

resource "aws_iam_role" "website-monitoring-role" {
  name = "Website-Monitoring-Server-IAM-Role"
  description = "IAM Role for Website Monitoring Server"
  assume_role_policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": "sts:AssumeRole",
            "Principal": {
                "Service": "ec2.amazonaws.com"
            }
        }
    ]
}
EOF
  tags = {
    Name = "Website Monitoring Server IAM Role"
  }
}

################################################################################################################################
#                                              IAM Policy
################################################################################################################################


resource "aws_iam_policy" "website-monitioring-policy" {
  name = "Website-Monitoring-Server-IAM-Policy"
  description = "IAM Policy for Website Monitoring Server"
  policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "ReadCloudWatchLogMetrics",
            "Effect": "Allow",
            "Action": [
                "cloudwatch:GetMetricData",
                "cloudwatch:GetMetricStatistics",
                "cloudwatch:ListMetrics",
                "cloudwatch:DescribeAlarms",
                "cloudwatch:DescribeAlarmHistory"
            ],
            "Resource": "*"
        },
        {
            "Sid": "DiscoverEC2Instances",
            "Effect": "Allow",
            "Action": [
                "ec2:DescribeInstances",
                "ec2:DescribeInstances",
                "ec2:DescribeRegions",
                "ec2:DescribeTags",
                "ec2:DescribeVolumes"
            ],
            "Resource": "*"
        }
    ]
}
EOF  
  tags = {
    Name = "Website Monitoring Server IAM Policy"
  }
}


################################################################################################################################
#                                            Role Policy Attachemnt
################################################################################################################################

resource "aws_iam_role_policy_attachment" "website-monitoring-role-policy" {
  role = aws_iam_role.website-monitoring-role.id
  policy_arn = aws_iam_policy.website-monitioring-policy.arn
}



################################################################################################################################
#                                              IAM Instance Profile
################################################################################################################################

resource "aws_iam_instance_profile" "website-monitoring-instance-profile" {
  role = aws_iam_role.website-monitoring-role.id
  name = "Website-Monitoring-Server-Instance-Profile"
}