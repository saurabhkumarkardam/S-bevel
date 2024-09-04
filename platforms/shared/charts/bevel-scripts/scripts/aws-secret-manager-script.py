import boto3
from botocore.exceptions import ClientError
import argparse
import json

session = boto3.session.Session()
client = session.client(
    service_name='secretsmanager',
    region_name='eu-central-1'
)

def create_secret(secret_name, secret_value):
    try:
        response = client.create_secret(
            Name=secret_name,
            Description="My application secret",
            SecretString=secret_value
        )
        print(f"Secret {secret_name} created successfully!")
        print(f"response {response}")
        return response
    except ClientError as e:
        print(f"Error creating secret: {e}")
        return None

def get_secret(secret_name):
    try:
        response = client.get_secret_value(SecretId=secret_name)
        secret = response['SecretString']
        print(f"Retrieved secret: {secret}")
        return secret
    except ClientError as e:
        print(f"Error retrieving secret: {e}")
        return None

def update_secret(secret_name, new_secret_value):
    try:
        response = client.update_secret(
            SecretId=secret_name,
            SecretString=new_secret_value
        )
        print(f"Secret {secret_name} updated successfully!")
        print(f"response {response}")
        return response
    except ClientError as e:
        print(f"Error updating secret: {e}")
        return None

def delete_secret(secret_name):
    try:
        response = client.delete_secret(
            SecretId=secret_name,
            ForceDeleteWithoutRecovery=True
        )
        print(f"Secret {secret_name} scheduled for deletion!")
        return response
    except ClientError as e:
        print(f"Error deleting secret: {e}")
        return None

if __name__ == "__main__":
    parser = argparse.ArgumentParser(description='Manage AWS Secrets')
    parser.add_argument('operation', choices=['create_secret', 'get_secret', 'update_secret', 'delete_secret'], help='Operation to perform')
    parser.add_argument('secret_name', help='Name of the secret')
    parser.add_argument('secret_value', nargs='?', default=None, help='Value of the secret (required for create and update)')

    args = parser.parse_args()

    # Check if secret_value is a file path
    secret_value = args.secret_value
    if secret_value and secret_value.endswith('.json'):
        try:
            with open(secret_value, 'r') as f:
                secret_value = json.dumps(json.load(f))
        except FileNotFoundError:
            print(f"Error: File {secret_value} not found.")
            exit(1)

    if args.operation == 'create_secret':
        create_secret(args.secret_name, secret_value)
    elif args.operation == 'get_secret':
        get_secret(args.secret_name)
    elif args.operation == 'update_secret':
        update_secret(args.secret_name, secret_value)
    elif args.operation == 'delete_secret':
        delete_secret(args.secret_name)
