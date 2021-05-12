import boto3
import requests
from requests_aws4auth import AWS4Auth

host = 'https://search-test-es-mxaywxwm33ywcaneqbfvuicqf4.us-east-1.es.amazonaws.com/' # include https:// and trailing /
region = 'us-east-1' # e.g. us-west-1
service = 'es'
credentials = boto3.Session().get_credentials()
awsauth = AWS4Auth(credentials.access_key, credentials.secret_key, region, service, session_token=credentials.token)

# Register repository

path = '_snapshot/development-elasticsearch-storage' # the Elasticsearch API endpoint
url = host + path

payload = {
  "type": "s3",
  "settings": {
    "bucket": "development-elasticsearch-storage",
    "endpoint": "s3.amazonaws.com",
    "role_arn": "arn:aws:iam::56415646135465416:role/development-elasticsearch-storage-Role"
  }
}

headers = {"Content-Type": "application/json"}

r = requests.put(url, auth=awsauth, json=payload, headers=headers)

print(r.status_code)
print(r.text)