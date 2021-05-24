# SQS

awslocal sqs create-queue \
--queue-name invoice-notification-mobile-dlq \
--region sa-east-1

awslocal sqs create-queue \
--queue-name invoice-notification-mobile \
--region sa-east-1 \
--attributes '{
  "RedrivePolicy": "{\"deadLetterTargetArn\":\"arn:aws:sqs:sa-east-1:000000000000:invoice-notification-mobile-dlq\",\"maxReceiveCount\":\"2\"}",
  "MessageRetentionPeriod": "259200",
  "VisibilityTimeout": "90"
}'

awslocal sqs create-queue \
--queue-name invoice-notification-email-dlq \
--region sa-east-1

awslocal sqs create-queue \
--queue-name invoice-notification-email \
--region sa-east-1 \
--attributes '{
  "RedrivePolicy": "{\"deadLetterTargetArn\":\"arn:aws:sqs:sa-east-1:000000000000:invoice-notification-email-dlq\",\"maxReceiveCount\":\"2\"}",
  "MessageRetentionPeriod": "259200",
  "VisibilityTimeout": "90"
}'

# SNS

awslocal sns create-topic \
--name invoice-notification

awslocal sns subscribe \
--topic-arn arn:aws:sns:sa-east-1:000000000000:invoice-notification \
--protocol sqs \
--notification-endpoint http://127.0.0.1:4566/000000000000/invoice-notification-mobile \
--attributes '{
"FilterPolicy": "{\"origin\": [\"MOBILE\"]}"
}'

awslocal sns subscribe \
--topic-arn arn:aws:sns:sa-east-1:000000000000:invoice-notification \
--protocol sqs \
--notification-endpoint http://127.0.0.1:4566/000000000000/invoice-notification-email \
--attributes '{
"FilterPolicy": "{\"origin\": [\"EMAIL\"]}"
}'


# S3

awslocal s3 mb s3://invoices \
--region sa-east-1