//
//  AWSRequest.swift
//  Crisp
//
//  Created by Jayesh Kaushik on 10/22/17.
//  Copyright © 2017 Crisp. All rights reserved.
//

import Foundation
import AWSCore
import AWSCognito
import AWSLambda
import AWSCognitoIdentityProvider

class AWSRequest{
    init() {
        
        
    }
    
   class func cognito(){
        

        let credentialsProvider = AWSCognitoCredentialsProvider(regionType:.USWest2,
                                                                identityPoolId:"us-west-2:279552b2-ac8c-4715-aaa2-369b309065c9")
        
        let configuration = AWSServiceConfiguration(region:.USWest2, credentialsProvider:credentialsProvider)
        
        AWSServiceManager.default().defaultServiceConfiguration = configuration
        
        let cognitoId = credentialsProvider.identityId

        
    }
    
    class func tester(){
    
    let lambdaInvoker = AWSLambdaInvoker.default()
    
    let jsonObject: [String: Any] = ["key1" : "value1",
                                     "key2" : 2,
                                     "key3" : [1, 2],
                                     "isError" : false]
    
    lambdaInvoker.invokeFunction("arn:aws:lambda:us-west-2:842626015625:function:crisp-get-expiration", jsonObject: jsonObject).continueWith(block: {(task:AWSTask<AnyObject>) -> Any? in
        if let error = task.error as NSError? {
    if error.domain == AWSLambdaInvokerErrorDomain && AWSLambdaInvokerErrorType.functionError == AWSLambdaInvokerErrorType(rawValue: error.code) {
        print("Function error: \(String(describing: error.userInfo[AWSLambdaInvokerFunctionErrorKey]))")
    } else {
    print("Error: \(error)")
    }
    return "nil"
    }
    
    // Handle response in task.result
    if let JSONDictionary = task.result as? NSDictionary {
    print("Result: \(JSONDictionary)")
        print("resultKey: \(String(describing: JSONDictionary["resultKey"]))")
    }
    return "nil"
    })
        
        
    
    }
    
}
