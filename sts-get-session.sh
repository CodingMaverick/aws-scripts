#!/bin/bash
MFA_ARN=YOUR_MFA_ARN
AWS_PROFILE=YOUR_AWS_PROFILE

# Some variables to manage files:
STS_TOKEN_TMP_FILE="./sts_token.json"
STS_SET_VARS_FILE="./sts_set_variables.sh"
STS_UNSET_VARS_FILE="./sts_unset_variables.sh"

# Check for positional parameter
if [ "$1" != "" ]; then
   TOKEN_CODE=$1
   # Get the session token and save it into ./sts_token.json
   aws sts get-session-token --serial-number $MFA_ARN --token-code $TOKEN_CODE --profile $AWS_PROFILE > $STS_TOKEN_TMP_FILE
   # Prepare the env variables
   AWS_ACCESS_KEY_ID=$(jq ".Credentials.AccessKeyId" $STS_TOKEN_TMP_FILE)
   AWS_SECRET_ACCESS_KEY=$(jq ".Credentials.SecretAccessKey" $STS_TOKEN_TMP_FILE)
   AWS_SESSION_TOKEN=$(jq ".Credentials.SessionToken" $STS_TOKEN_TMP_FILE)
   # Remove temporary JSON file
   rm $STS_TOKEN_TMP_FILE
   # Save 'set VARs' to $STS_SET_VARS_FILE
   echo "export AWS_ACCESS_KEY_ID=$AWS_ACCESS_KEY_ID" > $STS_SET_VARS_FILE
   echo "export AWS_SECRET_ACCESS_KEY=$AWS_SECRET_ACCESS_KEY" >> $STS_SET_VARS_FILE
   echo "export AWS_SESSION_TOKEN=$AWS_SESSION_TOKEN" >> $STS_SET_VARS_FILE
   # Save 'unset VARs' to $STS_UNSET_VARS_FILE
   echo "unset AWS_ACCESS_KEY_ID" > $STS_UNSET_VARS_FILE
   echo "unset AWS_SECRET_ACCESS_KEY" >> $STS_UNSET_VARS_FILE
   echo "unset AWS_SESSION_TOKEN" >> $STS_UNSET_VARS_FILE
 
   echo "\nWe're all set now. Please run 'source $STS_SET_VARS_FILE' to set the required environment variables, or 'source $STS_UNSET_VARS_FILE' to unset them"
else
    echo "Usage: sts-get-session.sh CODE-FROM-TOKEN"
fi
