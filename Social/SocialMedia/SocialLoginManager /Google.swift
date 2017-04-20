//
//  Google.swift
//  SocialMedia
//
//  Created by Sagar.Gupta on 14/04/17.
//  Copyright © 2017 Sagar.Gupta. All rights reserved.
//

import UIKit
import GoogleSignIn

protocol GoogleDeleagte {
    func googleWithSuccess(dict:[String : AnyObject],token:String)
    func googleWithErorr(erorr:String)
    func googlePresentViewController(vc:UIViewController)
    func googleDissmisviewController()
}

class Google: NSObject, GIDSignInUIDelegate, GIDSignInDelegate {
    
    static var share = Google()
    var delegate: GoogleDeleagte!
    private let googleSignIn = GIDSignIn.sharedInstance()
    
    override init() {
        super.init()
        googleSignInSetup()
    }
    
    
    /// Login vai Google
    private func googleSignInSetup() {
        googleSignIn?.shouldFetchBasicProfile = true
        googleSignIn?.delegate = self
        googleSignIn?.uiDelegate = self
    }
    
    internal func loginvaiGoogle() {
        googleSignIn?.signIn()
    }
    
    // MARK: - GOOGLE SIGN IN delegate method
    @objc(signIn:didSignInForUser:withError:) func sign(_: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        if let usr_ = user, let googleProfile = usr_.profile {
            var dict: [String:Any] = [:]
            dict["first_name"] = googleProfile.givenName
            dict["last_name"] = googleProfile.familyName
            dict["email"] = googleProfile.email
            dict["profile_url"] = googleProfile.hasImage ? googleProfile.imageURL(withDimension: 500).absoluteString : ""
            dict["social_id"] = user.userID
            print(dict)
            delegate.googleWithSuccess(dict: dict as [String : AnyObject], token: user.authentication.idToken)
        } else {
            delegate.googleWithErorr(erorr: error.localizedDescription)
        }
    }
    
    func sign(_ signIn: GIDSignIn!, present viewController: UIViewController!) {
        //self.present(viewController, animated: true, completion: nil)
        delegate.googlePresentViewController(vc: viewController)
    }
    
    func sign(_ signIn: GIDSignIn!, dismiss viewController: UIViewController!) {
        //self.dismiss(animated: true, completion: nil)
        delegate.googleDissmisviewController()
    }
}
