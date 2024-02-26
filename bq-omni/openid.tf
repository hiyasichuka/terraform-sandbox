#resource "aws_iam_openid_connect_provider" "default" {
#  url = "https://accounts.google.com"
#
#  client_id_list = [
#    google_bigquery_connection.connection.aws[0].access_role[0].identity,
#  ]
#
#  thumbprint_list = ["cf23df2207d99a74fbe169e3eba035e633b65d94"]
#}