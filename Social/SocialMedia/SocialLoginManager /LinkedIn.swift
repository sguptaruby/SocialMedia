//
//  LinkedIn.swift
//  SocialMedia
//
//  Created by Sagar.Gupta on 14/04/17.
//  Copyright © 2017 Sagar.Gupta. All rights reserved.

// First you need setup LinkedinSwift to in your project link is mention below.
// https://github.com/tonyli508/LinkedinSwift

import UIKit

@objc protocol LinkedInDelegate {
    @objc  optional func linkedUserLoginWithSuccess(token:String,userInfo:Any)
    @objc optional func linkedUserLoginWithError(error:String)
    @objc optional func linkedShareContentwithSuccess(response:String)
    @objc optional func linkedShareContentwithError(error:String)
}

class LinkedIn: NSObject {
    
    static var share = LinkedIn()
    var linkedinHelper: LinkedinSwiftHelper!
    var delegate: LinkedInDelegate!
    
    
    override init() {
        super.init()
    }
    
    /// Login linkedin get uer token
    
    func loginVaiLinkedin(clientId:String!,clientSecret:String!,state:String,permissions:[String],redirectUrl:String)  {
        linkedinHelper = LinkedinSwiftHelper(configuration: LinkedinSwiftConfiguration(clientId: clientId, clientSecret: clientSecret, state: state, permissions: permissions, redirectUrl: redirectUrl))
        linkedinHelper.authorizeSuccess({ [unowned self] (lsToken) -> Void in
            print(lsToken.accessToken)
            print(LISDKSessionManager.hasValidSession())
            self.getuserProfile(token: lsToken.accessToken)
            }, error: { [unowned self] (error) -> Void in
                self.delegate.linkedUserLoginWithError?(error: error.localizedDescription)
            }, cancel: { [unowned self] () -> Void in
                
        })
    }
    
    fileprivate func getuserProfile(token:String) {
        linkedinHelper.requestURL("https://api.linkedin.com/v1/people/~:(id,first-name,last-name,email-address,picture-url,picture-urls::(original),positions,date-of-birth,phone-numbers,location)?format=json", requestType: LinkedinSwiftRequestGet, success: { (response) -> Void in
            self.delegate.linkedUserLoginWithSuccess?(token: token, userInfo: response.jsonObject)
            //self.createSession(token: token)
        }) { [unowned self] (error) -> Void in
            self.delegate.linkedUserLoginWithError?(error: error.localizedDescription)
        }
    }
    
    func shareContentOnLinkedin(contetn:String)  {
        let payload = "{\"visibility\":[{\"code\":\"anyone\"}],\"comment\":\(contetn)\"}"
        print(LISDKSessionManager.hasValidSession())
        if LISDKSessionManager.hasValidSession() {
            LISDKAPIHelper.sharedInstance().postRequest("https://api.linkedin.com/v1/people/~/shares?format=json", stringBody: payload, success: { (response:LISDKAPIResponse?) in
                print(response ?? "")
                self.delegate.linkedShareContentwithSuccess?(response: (response?.data)!)
            }, error: { (error:LISDKAPIError?) in
                print(error.debugDescription)
                self.delegate.linkedShareContentwithError?(error: error.debugDescription)
            })
        }else{
            self.delegate.linkedShareContentwithError?(error:"session expire...")
        }
    }
}
