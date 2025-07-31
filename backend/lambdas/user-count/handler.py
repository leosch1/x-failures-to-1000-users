import json
import os

def lambda_handler(event, context):
    allowed_origin = os.getenv("ALLOWED_ORIGIN", "")

    data = {
        "Storylog": 0,
        "Vibe Radar": 30,
        "My YouTube Path": 12,
        "Spot The Pie": 4
    }

    return {
        "statusCode": 200,
        "headers": {
            "Access-Control-Allow-Origin": allowed_origin,
            "Access-Control-Allow-Headers": "Content-Type",
            "Access-Control-Allow-Methods": "GET,OPTIONS"
        },
        "body": json.dumps(data)
    }
