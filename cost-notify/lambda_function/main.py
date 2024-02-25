import boto3
import datetime


def lambda_handler(event, context):
    # AWS Cost Explorerを使用して請求額を取得する
    client = boto3.client('ce')
    today = datetime.date.today()
    start_date = today.replace(day=1)
    end_date = today
    response = client.get_cost_and_usage(
        TimePeriod={
            'Start': start_date.strftime('%Y-%m-%d'),
            'End': end_date.strftime('%Y-%m-%d')
        },
        Granularity='MONTHLY',
        Metrics=['BlendedCost']
    )

    # 請求額を抽出する
    cost_amount = response['ResultsByTime'][0]['Total']['BlendedCost']['Amount']
    cost_currency = response['ResultsByTime'][0]['Total']['BlendedCost']['Unit']

    # Slackに通知するメッセージを作成する
    message = f"AWSの今月の請求額は {cost_amount} {cost_currency} です。"

    # SlackのWebhook URLを設定する
    slack_webhook_url = 'YOUR_SLACK_WEBHOOK_URL'

    # Slackに通知を送信する
    #    requests.post(slack_webhook_url, json={'text': message}
    print(message)
