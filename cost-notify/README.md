# How to

機微情報のファイルを作成する
```sh
touch secret.tfvars
```

Secretの情報を記載する
```tf:sercret.tfvars
aws_access_key="***"
aws_sercret_key="***"
```

デプロイコマンド
```sh
terraform apply -var-file="secret.tfvars" -auto-approve
```