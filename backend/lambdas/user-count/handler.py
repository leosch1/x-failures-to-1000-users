import json
import boto3

def lambda_handler(event, context):
    data = {
        "Storylog": 0,
        "Vibe Radar": 30,
        "My YouTube Path": 12,
        "Spot The Pie": 4
    }

    return {
        "statusCode": 200,
        "headers": {
            "Access-Control-Allow-Origin": "schleo.com",
            "Access-Control-Allow-Headers": "Content-Type",
            "Access-Control-Allow-Methods": "GET,OPTIONS"
        },
        "body": json.dumps(data)
    }
