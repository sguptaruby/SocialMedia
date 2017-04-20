//
//  ShareViewController.swift
//  SocialMedia
//
//  Created by Sagar.Gupta on 17/04/17.
//  Copyright © 2017 Sagar.Gupta. All rights reserved.
//

import UIKit
import FBSDKShareKit
import FBSDKCoreKit

class ShareViewController: UIViewController,TwitterDelegate,LinkedInDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        Facebook.share.fbLinkShareWithFacebookButton(myContent: "https://developers.facebook.com/docs/sharing/ios/share-button", vc: self, frame: CGRect(x: 50, y: 80, width: 100, height: 40))
    }
    
    @IBAction func btnFBShare(sender:UIButton) {
     Facebook.share.fbLinkShareWithCustomButton(myContent: "https://developers.facebook.com/docs/sharing/ios/share-button", vc: self)
        
    }
    
    @IBAction func btnTweet(sender:UIButton) {
         TwitterLogin.share.delegate = self
        TwitterLogin.share.tweetsComposeView(vc: self, textContent: "Twitter", image: "https://developers.facebook.com/docs/sharing/ios/share-button")
        
    }
    
    @IBAction func btnLinkedin(sender:UIButton) {
        LinkedIn.share.delegate = self
        LinkedIn.share.shareContentOnLinkedin(contetn: "Hello")
    }
    
    func tweetWithSuccess(data: String) {
        showAlert(data: data, title: "Twitter")
    }
    
    func tweetWithErorr(erorr: String) {
        showAlert(data: erorr, title: "Twitter")
    }
    
    func showAlert(data:String,title:String)  {
        let alertVC = UIAlertController(title: title, message: data, preferredStyle: .alert)
        self.present(alertVC, animated: true, completion: nil)
        let okAction = UIAlertAction(title: "OK", style: .default, handler:nil)
        alertVC.addAction(okAction)
    }
    
    func linkedShareContentwithSuccess(response: String) {
        showAlert(data: response, title: "Shared")
    }
    
    func linkedShareContentwithError(error: String) {
        showAlert(data: error, title: "Error")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}
