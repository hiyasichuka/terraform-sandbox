Terraformコマンド
```
terraform apply -var-file="secret.tfvars" -auto-approve
```

sampleのcsvをダウンロードする
```sh
curl -o Chicago.csv https://data.cityofchicago.org/api/views/ijzp-q8t2/rows.csv?accessType=DOWNLOAD
```

## 注意事項

バケットを作成後、データをアップロードしておかないと外部テーブル作成でエラーが起きる

## IAM OpenID Connect provider

thumbprint_listの値はサービス(google,GitHub)毎に固有の値ぽい
https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_openid_connect_provider