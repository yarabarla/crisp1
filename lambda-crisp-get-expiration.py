
import boto3
import json
import http.client, urllib.request, urllib.parse, urllib.error, base64
import datetime

print('Loading function')
dynamo = boto3.client('dynamodb')

# Replace the subscription_key string value with your valid subscription key.


def respond(err, res=None):
    return {
        'statusCode': '400' if err else '200',
        'body': err.message if err else json.dumps(res),
        'headers': {
            'Content-Type': 'application/json',
        },
    }


def lambda_handler(event, context):
    #print("Received event: " + json.dumps(event, indent=2))
    operation = event['httpMethod']
    ayload = event['queryStringParameters'] if operation == 'GET' else json.loads(event['body'])
    
    print(payload)
    try:
        subscription_key = '4861ac6512c54d32b97f93a48fd69fd9'
        headers = {
            # Request headers.
            'Content-Type': 'application/json',
            'Ocp-Apim-Subscription-Key': subscription_key,
        }
        
        params = urllib.parse.urlencode({
            # Request parameters. The language setting "unk" means automatically detect the language.
            'language': 'unk',
            'detectOrientation ': 'true',
        })
        # The URL of a JPEG image containing text.
        #body = "{'url':'https://i.imgur.com/u0wbRo1.jpg'}"
        body = str(payload)
        print(body)
        # Execute the REST API call and get the response.
        conn = http.client.HTTPSConnection('westcentralus.api.cognitive.microsoft.com')
        conn.request("POST", "/vision/v1.0/ocr?%s" % params, body, headers)
        response = conn.getresponse()
        str_response = response.read().decode('utf-8')

        # 'data' contains the JSON data. The following formats the JSON data for display.
        parsed = json.loads(str_response)
        print("Parsed: {}".format(parsed))

        texts = []

        regions = parsed["regions"]
        for region in regions:
            lines = region["lines"]
            for line in lines:
                words = line["words"]
                for word in words:
                    text = word["text"]
                    texts.append(text)


        Ourdb = {"MILK": 7, "EGGS": 20, "PACKAGED MEATS" : 8, "BOLOGNA":12, "BAGEL":6, "BREAD":6, "RASPBERRIES":2, 
            "BANANA":6, "TOMATO":6, "PEACH":4, "POTATO":24, "AVOCADO":4, "GREEN BEAN":7, "KALE":6, "BROCCOLI":4, 
            "MUSHROOM":2, "ASPARAGUS":6, "HUMMUS":6, "YOGURT":10}

        now = datetime.datetime.now()
        new = {}
        for val in texts:
            for key in Ourdb:
                if val == key:
                    new[val] = {"daysUntilExpiration":Ourdb[key], "expirationDate":now.strftime("%Y-%m-%d")}

        print("New: {}".format(new))
        conn.close()
        return respond(None, new)
    except Exception as e:
        print('Error:')
        print(e)
        return respond(None, "failure")
