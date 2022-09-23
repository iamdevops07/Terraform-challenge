provider "aws" {
  region = var.region
}

resource "aws_db_instance" "demo-main" {
  allocated_storage                     = 23
  copy_tags_to_snapshot                 = true
  db_name                               = "demo"
  engine                                = "mysql"
  engine_version                        = "8.0.28"
  identifier                            = "demo-main"
  instance_class                        = "db.t3.micro"
  monitoring_interval                   = 60
  multi_az                              = true
  publicly_accessible                   = true
  skip_final_snapshot                   = true
  storage_encrypted                     = true
  storage_type                          = "gp2"
  username                              = "admin"
  vpc_security_group_ids                = [
      aws_security_group.default_rds_sg.id
  ]
}

resource "aws_db_snapshot" "rds-snapshot" {
  db_instance_identifier = aws_db_instance.demo-main.id
  db_snapshot_identifier = "main-db-snapshot"
}

resource "aws_db_instance" "db-main-restore" {
    instance_class         = "db.t3.micro"
    identifier             = "db-main-restore"
    username               = "admin"
    snapshot_identifier    = aws_db_snapshot.rds-snapshot.id
    vpc_security_group_ids = [aws_security_group.default_rds_sg.id]
    skip_final_snapshot    = true
}

resource "aws_sns_topic" "default" {
  name = "rds-events"
}

resource "aws_sns_topic_subscription" "email-target" {
  topic_arn = aws_sns_topic.default.arn
  protocol  = "email"
  endpoint  = "example@gmail.com"
}

resource "aws_db_event_subscription" "default" {
  name      = "rds-event-sub"
  sns_topic = aws_sns_topic.default.arn

  source_type = "db-instance"

  event_categories = [
    "creation",
    "failure",
  ]
}

resource "aws_security_group" "default_rds_sg" {
    name        = "default"
    description            = "default VPC security group"
    egress      = [
        {
            cidr_blocks      = [
                "0.0.0.0/0",
            ]
            description      = ""
            from_port        = 0
            ipv6_cidr_blocks = []
            prefix_list_ids  = []
            protocol         = "-1"
            security_groups  = []
            self             = false
            to_port          = 0
        },
    ]
    ingress     = [
        {
            cidr_blocks      = [
                "0.0.0.0/0",
            ]
            description      = ""
            from_port        = 3306
            ipv6_cidr_blocks = []
            prefix_list_ids  = []
            protocol         = "tcp"
            security_groups  = []
            self             = false
            to_port          = 3306
        },
        {
            cidr_blocks      = []
            description      = ""
            from_port        = 0
            ipv6_cidr_blocks = []
            prefix_list_ids  = []
            protocol         = "-1"
            security_groups  = []
            self             = true
            to_port          = 0
        },
    ]
}

