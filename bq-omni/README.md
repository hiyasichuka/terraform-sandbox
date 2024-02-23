Terraformコマンド
```
terraform apply -var-file="secret.tfvars" -auto-approve
```

sampleのcsvをダウンロードする
```sh
curl -o Chicago.csv https://data.cityofchicago.org/api/views/ijzp-q8t2/rows.csv?accessType=DOWNLOAD
```