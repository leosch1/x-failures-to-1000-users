import json
import os
import requests

def fetch_user_counts_from_posthog():
    posthog_api_key = os.getenv("POSTHOG_API_KEY") # This should be a personal API key
    base_url = "https://eu.posthog.com/api/projects/{project_id}/insights/{insight_id}"

    posthog_insight_mapping = {
        "Vibe Radar": {
            "project_id": "67446",
            "insight_id": "1040318",
            "correction": 0,
            "correction_factor": 0.66
        },
        "My YouTube Path": {
            "project_id": "19262",
            "insight_id": "1271863",
            "correction": -200,
            "correction_factor": 0.66
        },
        "Spot The Pie": {
            # "project_id": "",
            # "insight_id": "",
            "correction": 15
        }
    }

    headers = {
        "Authorization": f"Bearer {posthog_api_key}",
        "Content-Type": "application/json"
    }

    visitor_counts = {}

    for product_name, config in posthog_insight_mapping.items():
        try:
            if config["insight_id"]:
                url = base_url.format(
                    project_id=config["project_id"],
                    insight_id=config["insight_id"]
                )

                response = requests.get(url, headers=headers)
                response.raise_for_status()
                data = response.json()
                visitor_counts[product_name] = data["result"][0].get("count", 0)
            else:
                visitor_counts[product_name] = 0
        except Exception as e:
            print(f"Error fetching visitors for {product_name}: {e}")
            visitor_counts[product_name] = 0

        visitor_counts[product_name] = int(visitor_counts[product_name] * config.get("correction_factor", 1))
        visitor_counts[product_name] += config.get("correction", 0)

    return visitor_counts

def lambda_handler(event, context):
    allowed_origin = os.getenv("ALLOWED_ORIGIN", "")
    
    user_counts = fetch_user_counts_from_posthog()

    return {
        "statusCode": 200,
        "headers": {
            "Access-Control-Allow-Origin": allowed_origin,
            "Access-Control-Allow-Headers": "Content-Type",
            "Access-Control-Allow-Methods": "GET,OPTIONS"
        },
        "body": json.dumps(user_counts)
    }

if __name__ == "__main__":
    print(lambda_handler({}, {}))
