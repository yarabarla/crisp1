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

    Ourdb = {"Milk": 7, "Eggs": 20, "Packaged Meats" : 8, "Bologna":12, "Bagel":6, "Bread":6, "Raspberries":2, 
    "Banana":6, "Tomato":6, "Peach":4, "Potato":24, "Avocado":4, "Green Bean":7, "Kale":6, "Broccoli":4, 
    "Mushroom":2, "Asparagus":6, "Hummus":6, "Yogurt":10}

    new = {}
    for key in parsed:
        for key2 in Ourdb:
            if key == key2:
                new[key2] = Ourdb[key2]

    # print(str_response)

    print(parsed["regions"][0]['lines'][0]['words'][0]['text'])
    # print ("Response:")
    # print (json.dumps(parsed, sort_keys=True, indent=2))


    conn.close()

except Exception as e:
    print('Error:')
    print(e)

####################################