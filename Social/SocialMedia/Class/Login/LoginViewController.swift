//
//  LoginViewController.swift
//  SocialMedia
//
//  Created by Sagar.Gupta on 11/04/17.
//  Copyright © 2017 Sagar.Gupta. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController,LinkedInDelegate,FacebookDelegates,GoogleDeleagte,TwitterDelegate {
    
//    let linkedinHelper = LinkedinSwiftHelper(configuration: LinkedinSwiftConfiguration(clientId: "77tn2ar7gq6lgv", clientSecret: "iqkDGYpWdhf7WKzA", state: "DLKDJF46ikMMZADfdfds", permissions: ["r_basicprofile", "r_emailaddress"], redirectUrl: "https://github.com/tonyli508/LinkedinSwift"))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "ShareController") as! ShareViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func facebookLoing(sender:UIButton) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.socialMediaLogin = SocialMediaLoginTypes.Facebook
        Facebook.share.delegate = self
        Facebook.share.loginvaiFacebook(vc: self)
    }
    
    @IBAction func googleLoing(sender:UIButton) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.socialMediaLogin = SocialMediaLoginTypes.Google
        Google.share.delegate = self
        Google.share.loginvaiGoogle()
    }
    
    @IBAction func linkedinLoing(sender:UIButton) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.socialMediaLogin = SocialMediaLoginTypes.Linkedin
        LinkedIn.share.delegate = self
       LinkedIn.share.loginVaiLinkedin(clientId: "86supwye88ox4e", clientSecret: "POJvaTiHnCOPxquB", state: "some state", permissions: ["r_basicprofile","w_share"], redirectUrl: "https://example.com/auth/callback")
    }
    
    @IBAction func twitterLogin(sender:UIButton) {
        TwitterLogin.share.delegate = self
        TwitterLogin.share.loginVaiTwitter(vc: self)
    }
    
    //// TwitterLogin Delegates method
    
    func twitterWithSuccess(data: TWTRSession) {
        showAlert(data: data.authToken, title: "Twitter token")
    }
    
    func twitterWithErorr(erorr: String) {
        showAlert(data: erorr, title: "error")
    }
    
    //// Linkedin Delegates method
    
    func linkedUserLoginWithSuccess(token: String, userInfo: Any) {
        showAlert(data: token, title: "Linkedin token")
    }
    
    func linkedUserLoginWithError(error: String) {
        showAlert(data: error, title: "error")
    }
    
    /// Facebook Delegates method
    
    internal func facebookWithSuccess(dict: [String : AnyObject], token: String) {
        //showAlert(data: token, title: "Facebook token")
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "ShareController") as! ShareViewController
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
        
    func facebookWithErorr(erorr: String) {
        showAlert(data: erorr, title: "error")
    }
    
    /// Google Delegates method  
    
    func googlePresentViewController(vc: UIViewController) {
        self.present(vc, animated: true, completion: nil)
    }
    
    func googleDissmisviewController() {
        self.dismiss(animated: true, completion: nil)
    }
    
    func googleWithSuccess(dict: [String : AnyObject], token: String) {
        showAlert(data: token, title: "Google Token")
    }
    
    func googleWithErorr(erorr: String) {
        showAlert(data: erorr, title: "error")
    }
    
    func showAlert(data:String,title:String)  {
        let alertVC = UIAlertController(title: title, message: data, preferredStyle: .alert)
        self.present(alertVC, animated: true, completion: nil)
        let okAction = UIAlertAction(title: "OK", style: .default, handler:nil)
        alertVC.addAction(okAction)
    }
    
}
