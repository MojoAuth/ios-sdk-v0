//
//  ViewController.swift
//  SwiftDemo
//
//  Created by MojoAuth Development Team on 07/11/22.
//  Copyright © 2022 MojoAuthSDK. All rights reserved.


import MojoAuthSDK
//import GoogleSignIn
import FBSDKLoginKit
import FBSDKCoreKit
import UIKit


/* Google Native SignIn
 import GoogleSignIn
 */



class ViewController: UIViewController
/* Google Native SignIn
 , GIDSignInUIDelegate
 */
{
    func loginButton(_ loginButton: FBLoginButton, didCompleteWith result: LoginManagerLoginResult?, error: Error?) {
        
    }
    
    func loginButtonDidLogOut(_ loginButton: FBLoginButton) {
        
    }
    
    
    @IBOutlet weak var facebookButton: FBButton!
    
    @IBOutlet weak var validateButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //GIDSignIn.sharedInstance().delegate = self
        // Go to Profile VC if already login
        
        
        // facebookButton.delegate=self
        
    }
    
    //    @objc func loginButtonClicked(){
    //        let loginManager = LoginManager()
    //        loginManager.logIn(permissions: ["public_Profile"], from: self) {result, error in
    //            if let error = error{
    //                print("Encountered Error: \(error)")
    //            } else if let result = result, result.isCancelled{
    //                print("Cancelled.")
    //            }else {
    //                print("Logged In")
    //            }
    //
    //
    //        }
    //    }
    
    
    // Google Native SignIn
    
    
    let socialNativeLoginEnabled = AppDelegate.useGoogleNative  || AppDelegate.useFacebookNative
    //
    //        if(socialNativeLoginEnabled)
    //        {
    //            let nativeSocialLoginSection = Section("Native Social Login")
    //            form +++ nativeSocialLoginSection
    //
    //            if (AppDelegate.useAppleSignInNative)
    //            {
    //                nativeSocialLoginSection <<< ButtonRow("Native Apple")
    //                {
    //                    $0.title = "Apple Native Login"
    //                    }.onCellSelection{ cell, row in
    //                        self.actionHandleAppleSignin()
    //                }
    //               // self.setupSOAppleSignIn();
    //            }
    
    //            if (AppDelegate.useGoogleNative)
    //            {
    //                NotificationCenter.default.addObserver(self, selector: #selector(self.processGoogleNativeLogin), name: Notification.Name("userAuthenticatedFromNativeGoogle"), object: nil)
    //
    //                nativeSocialLoginSection <<< ButtonRow("Native Google")
    //                {
    //                    $0.title = "Google Native Login"
    //                    }.onCellSelection{ cell, row in
    //                        self.showNativeGoogleLogin()
    //                }
    //            }
    //
    //            if (AppDelegate.useFacebookNative)
    //            {
    //
    //                nativeSocialLoginSection <<< ButtonRow("Native Facebook")
    //                {
    //                    $0.title = "Facebook Native Login"
    //                    }.onCellSelection{ cell, row in
    //                        self.showNativeFacebookLogin()
    //                }
    //            }
    
    
    
    func showNativeGoogleLogin()
    {
        if let childVC = self.presentedViewController
        {
            childVC.dismiss(animated: false, completion: self.showNativeGoogleLogin)
            return
        }
        
        //Google Native Sign in
      //  GIDSignIn.sharedInstance().signIn()
        
    }
    
    //    @objc func processGoogleNativeLogin(notif:NSNotification)
    //    {
    //        if let userInfo = notif.userInfo
    //        {
    //            if let err = userInfo["error"] as? NSError
    //            {
    //                errorAlert(data:userInfo["data"] as? [AnyHashable : Any], error:err)
    //            }else
    //            {
    //                let data = userInfo["data"] as? [AnyHashable : Any]
    //                let access_token = data!["access_token"] as! NSString
    //
    //                AuthenticationAPI.authInstance().profiles(withAccessToken: access_token as String? , completionHandler: {(response, error) in
    //
    //                    self.checkRequiredFields(profile:response,token:access_token)
    //
    //                })
    //            }
    //        }
    //    }
    
    
    
    func showNativeFacebookLogin()
    {
        //        MojoAuthSocialLoginManager.sharedInstance().nativeFacebookLogin(withPermissions: ["facebookPermissions": ["public_profile"]], withSocialAppName: "MojoAuthDemo",  in: self, completionHandler: {( data, error) -> Void in
        //
        //            if let err = error {
        //                //self.errorAlert(data:data, error:err)
        //                print(err)
        //            } else {
        //                let access_token = data!["access_token"] as! NSString
        //
        //                AuthenticationAPI.authInstance().profiles(withAccessToken: access_token as String? , completionHandler: {(response, error) in
        //
        //                    //self.checkRequiredFields(profile:response,token:access_token)
        //
        //                })
        //            }
        //        })
    }
    
    
    
    
    
    
    
    
    
    @IBAction func GoggleLogin(_ sender: UIButton) {
        
        if AppDelegate.useGoogleNative == false{
            
            
            let alert = UIAlertController(title: "Confirm Configuration", message: "Please Complete Configuartion Details. ", preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
            
            
            self.present(alert, animated: true)
        }else{
            print ("Google Configuration true")
        }
        
        
        
    }
    
    
    
    @IBAction func FacebookLogin(_ sender: UIButton) {
        
        
        
        if AppDelegate.useFacebookNative == false{
            
            
            let alert = UIAlertController(title: "Confirm Configuration", message: "Please Complete Configuartion Details. ", preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
            //alert.addAction(UIAlertAction(title: "Continue", style: .cancel, handler: nil))
            
            self.present(alert, animated: true)
        }else{
            print ("Facebook Configuration true")
        }
        
        
        //        MojoAuthSocialLoginManager.sharedInstance().nativeFacebookLogin(withPermissions: ["facebookPermissions": ["public_profile"]], withSocialAppName: "MojoAuthDemo",  in: self, completionHandler: {( data, error) -> Void in
        //
        //            if error != nil {
        //                print(error!)
        //            }
        //
        //
        //            let access_token = data!["access_token"] as! NSString
        //            AuthenticationAPI.authInstance().profiles(withAccessToken: access_token as String? , completionHandler: {(response, error) in
        //
        //                self.checkRequiredFields(profile:response,token:access_token)
        //
        //
        //            }
        //            )}
        //            )
    }
    
    
    
    
    
    
    
   /*
    @objc(signIn:didSignInForUser:withError:) func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
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
        //            //@param socialAppName  should have unique social app name as a provider in case of multiple social apps for the same provider (eg. google_<social app name> )
        //
        //                MojoAuthSocialLoginManager.sharedInstance().convertGoogleToken(googleToken,google_refresh_token:refreshToken, google_client_id:clientID, in:currentVC, completionHandler: {( data ,  error) -> Void in
        //                NotificationCenter.default.post(name: Notification.Name("userAuthenticatedFromNativeGoogle"), object: nil, userInfo: ["data":data as Any,"error":error as Any])
        //                })
        //            }
        //        }
    }
    */
    
    
    
    
    
    @IBAction func validateButtonPressed(_ sender: UIButton)  {
        
        AuthenticationAPI.authInstance().validateToken("<token>", completionHandler: {(response, error)in
            if let err = error {
                print(err.localizedDescription)
            } else {
                print("Success")
            }
        })
    }
    
    
    
}










