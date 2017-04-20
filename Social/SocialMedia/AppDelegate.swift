//
//  AppDelegate.swift
//  SocialMedia
//
//  Created by Sagar.Gupta on 11/04/17.
//  Copyright © 2017 Sagar.Gupta. All rights reserved.
//

import UIKit
import IQKeyboardManager
import FBSDKLoginKit
import GoogleSignIn



enum SocialMediaLoginTypes:String {
    case Facebook = "Facebook"
    case Google = "Google"
    case Twitter = "Twitter"
    case Linkedin = "Linkedin"
}


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    var socialMediaLogin: SocialMediaLoginTypes!
    
    var kTwitterConsumerKey = "ukZ4p35gAlvpUH0QqECWz0B3R"
    var kTwitterConsumerSecret = "Hpekzc9jpLAVsIwgAGyDpk1mB5Ul9CeQuAN50sGdKEaUHv0NU3"
    
    
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        // Initialize sign-in
        GIDSignIn.sharedInstance().clientID = "1031699395445-rmbli9f26rgu5jqgtq10d11bdrh7gqdj.apps.googleusercontent.com"
        
        // Initialize Twitter
        Twitter.sharedInstance().start(withConsumerKey: kTwitterConsumerKey, consumerSecret: kTwitterConsumerSecret)
        Fabric.with([Twitter.sharedInstance()])
        
        IQKeyboardManager.shared().isEnabled = true
        FBSDKApplicationDelegate.sharedInstance().application(application, didFinishLaunchingWithOptions: launchOptions)
        return true
    }
    
    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }
    
    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }
    
    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
        FBSDKAppEvents.activateApp()
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
    
//    func application(_ app: UIApplication, open url: URL, options: [UIApplicationOpenURLOptionsKey : Any] = [:]) -> Bool {
//        
//        //        if Twitter.sharedInstance().application(app, open: url, options: options) {
//        //            return true
//        //        }else if FBSDKApplicationDelegate.sharedInstance().application(app, open: url, options: options) {
//        //            return true
//        //        }
//        return FBSDKApplicationDelegate.sharedInstance().application(app, open: url, options: options)
//    }
    
    func application(_ application: UIApplication, open url: URL, sourceApplication: String?, annotation: Any) -> Bool {
        // Linkedin sdk handle redirect
        //
        //       if socialMediaLogin == SocialMediaLoginTypes.Facebook {
        //             return FBSDKApplicationDelegate.sharedInstance().application(application, open: url, sourceApplication: sourceApplication, annotation: annotation)
        //        }else if socialMediaLogin == SocialMediaLoginTypes.Google {
        //            return GIDSignIn.sharedInstance().handle(url, sourceApplication: sourceApplication, annotation: annotation)
        //        }else if socialMediaLogin == SocialMediaLoginTypes.Linkedin{
        //            if LISDKCallbackHandler.shouldHandle(url) {
        //               return LISDKCallbackHandler.application(application, open: url, sourceApplication: sourceApplication, annotation: annotation)
        //            }
        //        }
        
        if LISDKCallbackHandler.shouldHandle(url) {
            return LISDKCallbackHandler.application(application, open: url, sourceApplication: sourceApplication, annotation: annotation)
        }
        return true
    }
    
    
    
    
}

