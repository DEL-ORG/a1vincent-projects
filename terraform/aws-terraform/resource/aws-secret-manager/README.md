## Delete secret through the CLi if Disable retention policy was not disable
```
aws secretsmanager delete-secret --secret-id your-secret-name --force-delete-without-recovery --region your-region

aws secretsmanager delete-secret --secret-id  2560-dev-del-postges-aurora-db-password --force-delete-without-recovery --region us-east-1
aws secretsmanager delete-secret --secret-id   2560-dev-del-mysql-aurora-db-password  --force-delete-without-recovery --region us-east-1
aws secretsmanager delete-secret --secret-id   2560-dev-del-postgres-db  --force-delete-without-recovery --region us-east-1
aws secretsmanager delete-secret --secret-id   2560-dev-del-mysql-db-password  --force-delete-without-recovery --region us-east-1
```

## Get secret information for RDS password
```s
# Get 2560-dev-del-postges-aurora-db-password
data "aws_secretsmanager_secret" "postges-aurora-db-password" {
  name = "2560-dev-del-postges-aurora-db-password"
}

data "aws_secretsmanager_secret_version" "postges-aurora-db-password" {
  secret_id = data.aws_secretsmanager_secret.postges-aurora-db-password.id
}


# Get 2560-dev-del-mysql-aurora-db-password
data "aws_secretsmanager_secret" "aurora-db-password" {
  name = "22560-dev-del-mysql-aurora-db-password"
}

data "aws_secretsmanager_secret_version" "aurora-db-password" {
  secret_id = data.aws_secretsmanager_secret.aurora-db-password.id
}
```

## CREATE A DATABASE WITH USERNAME AND PASSWORD
```
password = data.aws_secretsmanager_secret_version.postges-aurora-db-password.secret_string
username = data.aws_secretsmanager_secret_version.aurora-db-password.secret_string
```

## Another example
```s
# Get secret information for RDS password
data "aws_secretsmanager_secret" "rds_password" {
  name = "2568/alpha/db/databases-password"
}

data "aws_secretsmanager_secret_version" "rds_password" {
  secret_id = data.aws_secretsmanager_secret.rds_password.id
}

# Get secret information for RDS username
data "aws_secretsmanager_secret" "rds_username" {
  name = "2568/alpha/db/databases-username"
}

data "aws_secretsmanager_secret_version" "rds_username" {
  secret_id = data.aws_secretsmanager_secret.rds_username.id
}


## CREATE A DATABASE WITH USERNAME AND PASSWORD
password = data.aws_secretsmanager_secret_version.rds_password.secret_string
username = data.aws_secretsmanager_secret_version.rds_username.secret_string
```