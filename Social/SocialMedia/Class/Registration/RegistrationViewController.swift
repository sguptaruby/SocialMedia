//
//  RegistrationViewController.swift
//  SocialMedia
//
//  Created by Sagar.Gupta on 11/04/17.
//  Copyright © 2017 Sagar.Gupta. All rights reserved.
//

import UIKit


class RegistrationViewController: UIViewController,InstagramDelegats {
    
    @IBOutlet var webview:UIWebView!
    var instagram: Instagram!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
       
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func btnInstagram(sender :UIButton) {
        instagram = Instagram(frame: CGRect(x: 0, y: 0, width:view.frame.size.width, height: view.frame.size.height), vc: self)
        instagram.delagte = self
        instagram.instagramLogin()
    }
    
    func instaWithSuccess(token: String) {
        instagram.webview.isHidden = true
        self.showAlert(data: token, title: "InstagramToken")
    }
    
    func instaWithError(error: String) {
        instagram.webview.isHidden = true
    }
    
    func showAlert(data:String,title:String)  {
        let alertVC = UIAlertController(title: title, message: data, preferredStyle: .alert)
        self.present(alertVC, animated: true, completion: nil)
        let okAction = UIAlertAction(title: "OK", style: .default, handler:nil)
        alertVC.addAction(okAction)
    }


}
