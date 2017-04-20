//
//  InstagramController.swift
//  SocialMedia
//
//  Created by Sagar.Gupta on 20/04/17.
//  Copyright © 2017 Sagar.Gupta. All rights reserved.
//

import UIKit

protocol InstagramDelegats {
    func instaWithSuccess(token:String)
    func instaWithError(error:String)
}

class Instagram: NSObject,UIWebViewDelegate {
    
    /// web view
    var webview: UIWebView!
    var delagte: InstagramDelegats!
    
   init(frame:CGRect,vc:UIViewController) {
       super.init()
        webview = UIWebView(frame: CGRect.init(x:frame.origin.x, y:frame.origin.y, width:frame.size.width, height:frame.size.height))
        vc.view.addSubview(webview)
        webview.delegate = self
    }
    
    internal func instagramLogin()  {
        let scop:InstagramKitLoginScope = .comments
        let authURL = InstagramEngine.shared().authorizationURL(for: scop)
        webview.loadRequest(URLRequest.init(url:authURL))
    }

    /// web view delegates methos
    ///
    func webView(_ webView: UIWebView, shouldStartLoadWith request: URLRequest, navigationType: UIWebViewNavigationType) -> Bool {
        print(request.url ?? "")
        if let toke = try? InstagramEngine.shared().receivedValidAccessToken(from: request.url!) {
            print(toke)
            self.delagte.instaWithSuccess(token: InstagramEngine.shared().accessToken!)
        }
        return true
    }
    
    func webView(_ webView: UIWebView, didFailLoadWithError error: Error) {
        print(error.localizedDescription)
        self.delagte.instaWithError(error: "")
    }
    
    
}
