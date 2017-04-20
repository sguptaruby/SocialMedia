//
//  Twitter.swift
//  SocialMedia
//
//  Created by Sagar.Gupta on 14/04/17.
//  Copyright © 2017 Sagar.Gupta. All rights reserved.
//

import UIKit

@objc protocol TwitterDelegate {
   @objc optional func twitterWithSuccess(data:TWTRSession)
   @objc optional func twitterWithErorr(erorr:String)
   @objc optional func tweetWithSuccess(data:String)
   @objc optional func tweetWithErorr(erorr:String)
}

class TwitterLogin: NSObject {
    
    static var share = TwitterLogin()
    var delegate: TwitterDelegate!
    
    override init() {
        super.init()
    }
    
    /// Login vai twitter
    
    func loginVaiTwitter(vc:UIViewController!)  {
        Twitter.sharedInstance().logIn(with: vc) { (response:TWTRSession?, error:Error?) in
            if error == nil {
                print(response?.authToken ?? "")
                self.delegate.twitterWithSuccess?(data: response!)
            }else{
                print(error.debugDescription)
                self.delegate.twitterWithErorr?(erorr:error.debugDescription)
            }
        }
    }
    
    internal func tweetsComposeView(vc:UIViewController!,textContent:String?,image:String?)  {
        let composer = TWTRComposer()
        if self.canOpenURL(string: image) {
            let url = URL(string: image!)
            let data = try? Data(contentsOf: url!)
            composer.setImage(UIImage(data: data!))
        }else{
            composer.setImage(UIImage(named: image!))
        }
        composer.setText(textContent ?? "")
        
        // Called from a UIViewController
        composer.show(from: vc) { result in
            if (result == TWTRComposerResult.cancelled) {
                print("Tweet composition cancelled")
                self.delegate.tweetWithErorr?(erorr: "Tweet composition cancelled")
            }
            else {
                self.delegate.tweetWithSuccess?(data: "Send tweet!")
                print("Sending tweet!")
            }
        }
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
