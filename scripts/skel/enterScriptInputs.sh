#!/bin/bash

CREDS=./creds.json

if [ -f "$CREDS" ]
then
    DT_HOSTNAME=$(cat creds.json | jq -r '.dynatraceHostName')
    DT_API_TOKEN=$(cat creds.json | jq -r '.dynatraceApiToken')
    DT_PAAS_TOKEN=$(cat creds.json | jq -r '.dynatracePaaSToken')
    GITHUB_PERSONAL_ACCESS_TOKEN=$(cat creds.json | jq -r '.githubPersonalAccessToken')
    GITHUB_USER_NAME=$(cat creds.json | jq -r '.githubUserName')
    GITHUB_ORGANIZATION=$(cat creds.json | jq -r '.githubOrg')
fi

echo "==================================================================="
echo -e "Please enter the values for provider type: $DEPLOYMENT_NAME:"
echo "==================================================================="
echo "Dynatrace Host Name (e.g. https://abc12345.live.dynatrace.com)"
read -p "                                       (current: $DT_HOSTNAME) : " DT_HOSTNAME_NEW
read -p "Dynatrace API Token                    (current: $DT_API_TOKEN) : " DT_API_TOKEN_NEW
read -p "Dynatrace PaaS Token                   (current: $DT_PAAS_TOKEN) : " DT_PAAS_TOKEN_NEW
read -p "GitHub User Name                       (current: $GITHUB_USER_NAME) : " GITHUB_USER_NAME_NEW
read -p "GitHub Personal Access Token           (current: $GITHUB_PERSONAL_ACCESS_TOKEN) : " GITHUB_PERSONAL_ACCESS_TOKEN_NEW
read -p "GitHub Organization                    (current: $GITHUB_ORGANIZATION) : " GITHUB_ORGANIZATION_NEW

echo "==================================================================="
echo ""
# set value to new input or default to current value
DT_HOSTNAME=${DT_HOSTNAME_NEW:-$DT_HOSTNAME}
DT_API_TOKEN=${DT_API_TOKEN_NEW:-$DT_API_TOKEN}
DT_PAAS_TOKEN=${DT_PAAS_TOKEN_NEW:-$DT_PAAS_TOKEN}
GITHUB_USER_NAME=${GITHUB_USER_NAME_NEW:-$GITHUB_USER_NAME}
GITHUB_PERSONAL_ACCESS_TOKEN=${GITHUB_PERSONAL_ACCESS_TOKEN_NEW:-$GITHUB_PERSONAL_ACCESS_TOKEN}
GITHUB_USER_EMAIL=${GITHUB_USER_EMAIL_NEW:-$GITHUB_USER_EMAIL}
GITHUB_ORGANIZATION=${GITHUB_ORGANIZATION_NEW:-$GITHUB_ORGANIZATION}

echo -e "Please confirm all are correct:"
echo ""
echo "Dynatrace Host Name          : $DT_HOSTNAME"
echo "Dynatrace API Token          : $DT_API_TOKEN"
echo "Dynatrace PaaS Token         : $DT_PAAS_TOKEN"
echo "GitHub User Name             : $GITHUB_USER_NAME"
echo "GitHub Personal Access Token : $GITHUB_PERSONAL_ACCESS_TOKEN"
echo "GitHub Organization          : $GITHUB_ORGANIZATION" 

echo "==================================================================="
read -p "Is this all correct? (y/n) : " -n 1 -r
echo ""
echo "==================================================================="

if [[ $REPLY =~ ^[Yy]$ ]]
then
    echo "Making a backup $CREDS to $CREDS.bak"
    cp $CREDS $CREDS.bak 2> /dev/null
    rm $CREDS 2> /dev/null

    cat ./creds.template | \
      sed 's~DYNATRACE_HOSTNAME_PLACEHOLDER~'"$DT_HOSTNAME"'~' | \
      sed 's~DYNATRACE_API_TOKEN_PLACEHOLDER~'"$DT_API_TOKEN"'~' | \
      sed 's~DYNATRACE_PAAS_TOKEN_PLACEHOLDER~'"$DT_PAAS_TOKEN"'~' | \
      sed 's~GITHUB_USER_NAME_PLACEHOLDER~'"$GITHUB_USER_NAME"'~' | \
      sed 's~PERSONAL_ACCESS_TOKEN_PLACEHOLDER~'"$GITHUB_PERSONAL_ACCESS_TOKEN"'~' | \
      sed 's~GITHUB_ORG_PLACEHOLDER~'"$GITHUB_ORGANIZATION"'~' > $CREDS

    echo ""
    echo "The updated credentials file can be found here: $CREDS"
    echo ""
fi