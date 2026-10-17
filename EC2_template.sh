
#!/bin/bash

set -e

# Step 1: Validate the template
aws cloudformation validate-template \
    --template-body file:///home/saihanu/EC2_template.yaml \
    --region ap-south-1 \
    --profile prod

echo "Template validation successful"

# Step 2: Create the stack
aws cloudformation create-stack \
    --stack-name ec2stack \
    --template-body file:///home/saihanu/EC2_template.yaml \
    --parameters ParameterKey=SecurityGroupId,ParameterValue=sg-0ca4a617d57971c13 \
    --region ap-south-1 \
    --profile prod

# Step 3: Wait for stack creation
aws cloudformation wait stack-create-complete \
    --stack-name ec2stack \
    --region ap-south-1 \
    --profile prod

# Step 4: Display success
echo "Successfully created stack"

