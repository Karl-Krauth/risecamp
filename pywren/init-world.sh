#!/bin/bash

echo "[default]" > /home/$NB_USER/.aws/credentials
echo "aws_access_key_id = $AWS_ACCESS_KEY_ID" >> /home/$NB_USER/.aws/credentials
echo "aws_secret_access_key = $AWS_SECRET_ACCESS_KEY" >> /home/$NB_USER/.aws/credentials
cat ~/.aws/credentials
pywren create_config
sed -i s/" bucket:.*"/" bucket: pywren.bucket.`echo "$AWS_ACCESS_KEY_ID" | md5sum | cut -f1 -d' '`"/ /home/$NB_USER/.pywren_config
pywren create_bucket || echo "bucket already created"
sed -i s/" aws_account_id:.*"/" aws_account_id: $ACCOUNT_ID"/ /home/$NB_USER/.pywren_config 
sed -i s/" aws_lambda_role:.*"/" aws_lambda_role: lambda_role"/ /home/$NB_USER/.pywren_config
# pywren create-role
pywren deploy_lambda
