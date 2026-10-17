
#!/bin/bash

FILE="/home/saihanu/s3_bucket_creation.yaml"

if [ ! -f "$FILE" ]; then
    echo "Invalid file: $FILE"
    exit 1
fi

echo "Validating CloudFormation template..."

aws cloudformation validate-template \
    --template-body "file://$FILE" \
    --region ap-south-1 \
    --profile dev

if [ $? -ne 0 ]; then
    echo "Template validation failed"
    exit 1
fi

echo "Creating CloudFormation stack..."

aws cloudformation create-stack \
    --stack-name MyS3stack \
    --template-body "file://$FILE" \
    --region ap-south-1 \
    --profile dev

if [ $? -ne 0 ]; then
    echo "Stack creation request failed"
    exit 1
fi

aws cloudformation wait stack-create-complete \
    --stack-name MyS3stack \
    --region ap-south-1 \
    --profile dev

echo "Stack created successfully!"

