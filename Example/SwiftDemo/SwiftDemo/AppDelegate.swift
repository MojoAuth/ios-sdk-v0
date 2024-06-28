//
//  AppDelegate.swift
//  SwiftDemo
//
//  Created by MojoAuth Development Team on 18/05/16.
//  Copyright © 2022 MojoAuth All rights reserved.
//

import UIKit
import MojoAuthSDK
import FBSDKLoginKit
import FBSDKCoreKit
//import GoogleSignIn


/* Google Native Sign in
import GoogleSignIn
*/



@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate
/* Google Native SignIn
, GIDSignInDelegate
*/
{

    var window: UIWindow?
    
    // This is up to the customer to configure their app to enable native social logins.
    static var useGoogleNative:Bool = false
    static var useFacebookNative:Bool = false


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.

    
        
        
        let sdk:MojoAuthSDK = MojoAuthSDK.instance();
        sdk.applicationLaunched(options: launchOptions);
     

        // Google Native Sign in
        //GIDSignIn.sharedInstance().clientID = "Your_Client_ID"
       // GIDSignIn.sharedInstance().delegate = self
        
        
        
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool
    {
        var canOpen = false
        
        /* Google Native Sign in
        canOpen = (canOpen || GIDSignIn.sharedInstance().handle(url, sourceApplication: options[UIApplicationOpenURLOptionsKey.sourceApplication] as! String, annotation: options[UIApplicationOpenURLOptionsKey.annotation]))
        */
        


        canOpen = (canOpen || MojoAuthSDK.sharedInstance().application(app, open: url, sourceApplication: options[UIApplication.OpenURLOptionsKey.sourceApplication] as? String, annotation: options[UIApplication.OpenURLOptionsKey.annotation]))

        return canOpen
    }

    /* Google Native Sign in
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
    
//        if let err = error
//        {
//            print("Error: \(err.localizedDescription)")
//        }
//        else
//        {
//            let googleToken: String = user.authentication.accessToken
//            let refreshToken: String = user.authentication.refreshToken
//            let clientID: String = user.authentication.clientID
//            if let navVC = self.window?.rootViewController as? UINavigationController,
//            let currentVC = navVC.topViewController
//            {
//                MojoAuthSocialLoginManager.sharedInstance().convertGoogleToken(toMojoAuthToken: googleToken,google_refresh_token:refreshToken, google_client_id:clientID,  in:currentVC, completionHandler: {( data ,  error) -> Void in
//                NotificationCenter.default.post(name: Notification.Name("userAuthenticatedFromNativeGoogle"), object: nil, userInfo: ["data":data as Any,"error":error as Any])
//
//                })
//            }
//        }
    }
    */
}

