########### Python 3.6 #############
import http.client, urllib.request, urllib.parse, urllib.error, base64, json

###############################################
#### Update or verify the following values. ###
###############################################

# Replace the subscription_key string value with your valid subscription key.
subscription_key = '4861ac6512c54d32b97f93a48fd69fd9'

# Replace or verify the region.
#
# You must use the same region in your REST API call as you used to obtain your subscription keys.
# For example, if you obtained your subscription keys from the westus region, replace 
# "westcentralus" in the URI below with "westus".
#
# NOTE: Free trial subscription keys are generated in the westcentralus region, so if you are using
# a free trial subscription key, you should not need to change this region.
uri_base = 'https://westcentralus.api.cognitive.microsoft.com/vision/v1.0'

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
body = "{'url':'https://i.imgur.com/u0wbRo1.jpg'}"

try:
    # Execute the REST API call and get the response.
    conn = http.client.HTTPSConnection('westcentralus.api.cognitive.microsoft.com')
    conn.request("POST", "/vision/v1.0/ocr?%s" % params, body, headers)
    response = conn.getresponse()
    str_response = response.read().decode('utf-8')

    # 'data' contains the JSON data. The following formats the JSON data for display.
    parsed = json.loads(str_response)

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

    new = {}
    for val in texts:
        for key in Ourdb:
            if val == key:
                new[val] = Ourdb[key]

    # print(str_response)
    # print(texts)
    print(new)
    # print(parsed["regions"][0]['lines'][0]['words'][0]['text'])
    # print ("Response:")
    # print (json.dumps(parsed, sort_keys=True, indent=2))


    conn.close()

except Exception as e:
    print('Error:')
    print(e)

####################################