//
//  Facebook.swift
//  SocialMedia
//
//  Created by Sagar.Gupta on 14/04/17.
//  Copyright © 2017 Sagar.Gupta. All rights reserved.
//

import UIKit
import FBSDKLoginKit
import FBSDKShareKit

protocol FacebookDelegates {
    func facebookWithSuccess(dict:[String : AnyObject],token:String)
    func facebookWithErorr(erorr:String)
}

class Facebook: NSObject {
    
    static var share = Facebook()
    var delegate: FacebookDelegates!
    
    override init() {
        super.init()
    }
    
    /// Login vai facebook
    internal func loginvaiFacebook(vc:UIViewController!) {
        let fbLoginManager : FBSDKLoginManager = FBSDKLoginManager()
        fbLoginManager.logIn(withReadPermissions: ["email"], from:vc) { (result, error) in
            if (error == nil){
                let fbloginresult : FBSDKLoginManagerLoginResult = result!
                if fbloginresult.grantedPermissions != nil {
                    if(fbloginresult.grantedPermissions.contains("email"))
                    {
                        self.getFBUserData()
                        //fbLoginManager.logOut()
                    }
                }
            }
        }
    }
    /// Get user information from facebook
    private func getFBUserData(){
        if((FBSDKAccessToken.current()) != nil){
            FBSDKGraphRequest(graphPath: "me", parameters: ["fields": "id, name, first_name, last_name, picture.type(large), email"]).start(completionHandler: { (connection, result, error) -> Void in
                if (error == nil){
                    let dict = result as! [String : AnyObject]
                    self.delegate.facebookWithSuccess(dict: dict, token: FBSDKAccessToken.current().tokenString)
                }else{
                    self.delegate.facebookWithErorr(erorr: (error?.localizedDescription)!)
                }
            })
        }
    }
    
    /// Facebook Link sharing with custom button
    internal func fbLinkShareWithCustomButton(myContent:String!,vc:UIViewController!) {
        if !self.canOpenURL(string: myContent) {
            return
        }
        let content = FBSDKShareLinkContent.init()
        content.contentURL = URL(string: myContent)
        FBSDKShareDialog.show(from: vc, with: content, delegate: nil)
    }
    
    /// Facebook sharing with facebook button
    internal func fbLinkShareWithFacebookButton(myContent:String!,vc:UIViewController!,frame:CGRect) {
        if !self.canOpenURL(string: myContent) {
            return
        }
        let content = FBSDKShareLinkContent.init()
        content.contentURL = URL(string: myContent)
        let shareButton = FBSDKShareButton()
        shareButton.shareContent = content
        shareButton.frame = frame
        vc.view.addSubview(shareButton)
    }

    fileprivate func canOpenURL(string: String?) -> Bool {
        guard let urlString = string else {return false}
        guard let url = NSURL(string: urlString) else {return false}
        if !UIApplication.shared.canOpenURL(url as URL) {return false}
        
        //
        let regEx = "((https|http)://)((\\w|-)+)(([.]|[/])((\\w|-)+))+"
        let predicate = NSPredicate(format:"SELF MATCHES %@", argumentArray:[regEx])
        return predicate.evaluate(with: string)
    }
    
}
