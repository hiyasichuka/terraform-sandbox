## リリース手順

シークレットファイルを作成する

```secret.tfvars
gcp_credential = "****.json"
gcp_project_id = "****"
aws_access_key = "****"
aws_secret_key = "****"
```

デプロイを実行

```sh
# terraform init ←ローカルで実行する場合、初回のみ実行
terraform apply -var-file="secret.tfvars" -auto-approve
```

## 検証用サンプルデータ

sampleのcsvをダウンロードして、S3バケットにアップロードする

```sh
curl -o zillow.csv https://people.sc.fsu.edu/~jburkardt/data/csv/zillow.csv
aws s3 cp zillow.csv s3://my-sample-files-8888/ --profile=PROFILE_NAME
```

## 注意事項

バケットを作成後、データをアップロードしておかないと外部テーブル作成でエラーが起きる

## IAM OpenID Connect provider

thumbprint_listの値はサービス(google,GitHub)毎に固有の値ぽい
https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_openid_connect_provider