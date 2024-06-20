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

sample の tsv を S3 バケットにアップロードする

```sh

aws s3 cp sample-data.tsv s3://test-bucket-888888/ --profile=PROFILE_NAME
```

## BigLake テーブル作成

<PROJECT>は、secret.tfvars の gcp_project_id で書き換える。

```
CREATE OR REPLACE EXTERNAL TABLE
  `<PROJECT>.aws_dataset.sample`
WITH CONNECTION `projects/<PROJECT>/locations/aws-us-west-2/connections/aws-connection` OPTIONS( format="CSV",
    uris=["s3://test-bucket-888888/*.tsv"],
    max_staleness = INTERVAL 1 DAY,
    metadata_cache_mode = "AUTOMATIC" );

```

ネイティブテーブルの作成

```
CREATE OR REPLACE TABLE `dataset.target` (
    AFFGEOID STRING,
    STATE STRING
);
```

BigLake テーブルからネイティブへのマージ

```
MERGE INTO
  dataset.target AS T
USING
  aws_dataset.sample AS S
ON
  T.AFFGEOID = S.AFFGEOID
  WHEN MATCHED THEN UPDATE SET T.STATE = S.STATE
  WHEN NOT MATCHED
  THEN
INSERT
  (AFFGEOID,
    STATE)
VALUES
  (S.AFFGEOID,S.STATE);
```

## 注意事項

バケットを作成後、データをアップロードしておかないと外部テーブル作成でエラーが起きる

## IAM OpenID Connect provider

thumbprint_list の値はサービス(google,GitHub)毎に固有の値ぽい
https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_openid_connect_provider
