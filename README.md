# MojoAuth iOS SDK


## Introduction ##
MojoAuth helps to Create a passwordless authentication system for any organization, where they can use our APIs to provide seamless auth experiences and reduce security risks for their customer.


MojoAuth helps businesses boost user engagement on their web/mobile platform, manage online identities, utilize social media for marketing, capture accurate consumer data, and get unique social insight into their customer base.

Please visit [here](https://mojoauth.com/) for more information.

## Documentation
For full documentation visit [here](https://mojoauth.com/docs/)

## Author

[MojoAuth](https://www.mojoauth.com/)

## License

This project is licensed under the MIT license. See the [LICENSE](LICENSE) file for more info.


#### There are three projects in the library:

a. SwiftDemo - This is the demo application in Swift(Supported Swift version 5).<br>
b. MojoAuthSDK -This is the MojoAuth SDK.


## Installing SDK

We recommend using CocoaPods for installing the library in a project.

CocoaPods is a dependency manager for Cocoa projects. You can install it with the following command:


```
$ gem install cocoapods
```

### Podfile

Open a terminal window and navigate to the location of the Xcode project for your application. If you have not already created a Podfile for your application, create one now:


```
$ pod init
```

To integrate MojoAuthSDK into your Xcode project using CocoaPods, specify it in your Podfile:


```
source 'https://github.com/CocoaPods/Specs.git'
platform :ios, '11.0'

target 'TargetName' do

#Comment the next line if you don't want to use dynamic frameworks
use_frameworks!
pod 'MojoAuthSDK', '~> 1.0.0'
end

```

Then, run the following command:


```
$ pod install

```

## Initialize SDK

*Create a new File MojoAuth.plist and add it to your App*

Add the MojoAuth *apiKey* with type *String*

```apiKey  = <MojoAuth API Key>```


*After that Import the module in your source code.*


```
import MojoAuthSDK

```

*Application is launched*


```
import MojoAuthSDK
 ...


@UIApplicationMain class AppDelegate: UIResponder, UIApplicationDelegate {


...

func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions:[UIApplicationLaunchOptionsKey: Any]?) -> Bool {

            let sdk:MojoAuthSDK = MojoAuthSDK.instance();
            sdk.applicationLaunched(options: launchOptions);

            //Your code

            return true
 }

...

}
```

*Application is asked to open URL*

Call this to handle URL's for social login to work properly in your AppDelegate.m


```
@UIApplicationMain class AppDelegate: UIResponder, UIApplicationDelegate {
...

func application(_ app: UIApplication, open url: URL, options: [UIApplicationOpenURLOptionsKey : Any] = [:]) -> Bool {
return MojoAuthSDK.sharedInstance().application(app, open: url, sourceApplication: options[UIApplicationOpenURLOptionsKey.sourceApplication] as? String, annotation: options[UIApplicationOpenURLOptionsKey.annotation])
}
...

}
...
}

```

## MojoAuth SDK API Methods


### Send magic link on the email

This endpoint sends a magiclink to your email.

```
    func MagicLink()
        {
        
        AuthenticationAPI.authInstance().sendMagicLink(withEmail: "email", language: "language", redirect_url: "url", completionHandler: {(response,error)in
            if let e = error{
                print(e.localizedDescription)
            }else{
                print("Successfull in sending magic link.")
            }
            })
    }
```
    
## Check Authentication status

This endpoint checks the login status of user.
    
```
    func CheckAuthenticationStatus()
        {
        
        AuthenticationAPI.authInstance().checkAuthenticationStatus(withStateID: "id", language: "language", redirect_url: "url", completionHandler: {(response,error)in
            if let err = error{
                print(err.localizedDescription)
            }else{
                print("Sucess")
            }
        })
    }
```
    
## Resend magic link

This endpoint resends a magiclink to your email.
    
```
 func ResendMagicLink() 
        {
        AuthenticationAPI.authInstance().resendMagicLink(withStateID: "id", language: "language", redirect_url: "url", completionHandler: {(response,error)in
            if let e = error{
                print(e.localizedDescription)
            }else{
                print("Success in resending magic link.")
            }
        })
    }
    
```

## Send Email OTP

This endpoint sends Email OTP on the mentioned Email Address.
    
```
    func SendEmailOtp()
        {
        AuthenticationAPI.authInstance().sendEmailOTP(withEmail: "email", language: "language", completionHandler: {(response,error)
            in
                if let e = error{
                    print(e.localizedDescription)
                }else{
                    print("Success")
                }
        })
    }
```

## Verify Email OTP

This endpoint Verify OTP and returns user response and access token

```
func VerifyEmailOtp()
    {
        
        AuthenticationAPI.authInstance().verifyEmailOTP(withStateID: "stateId", otp: "Otp", completionHandler: {(response,error)in
                if let e = error{
                    print(e.localizedDescription)
                }else{
                    print("Success")
                }
        })
        
    }
```
    
## Resend Email OTP

This endpoint resends an OTP to your email.
    
```
    func ResendEmailOtp()
        {
        
        AuthenticationAPI.authInstance().resendEmailOTP(withStateID: "stateId", language: "language", completionHandler: {(response,error) in
                if let e = error{
                    print(e.localizedDescription)
                }else{
                    print("Success")
                }
        })
    }
    
 ```   
 
## Send Phone OTP

This endpoint sends Phone OTP on the mentioned Phone Number.
    
```
  func SendPhoneOtp()
      {
        
        AuthenticationAPI.authInstance().sendPhoneOTP(withPhone: "phoneNo.", language: "language", completionHandler: {(response,error) in
                if let e = error{
                    print(e.localizedDescription)
                }else{
                    print("Success")
                }
        })
    }
      
```

 
## Verify Phone OTP

This endpoint verify Phone OTP on the mentioned Phone Number.
   
```
func VerifyPhoneOTP()
    {
        
        AuthenticationAPI.authInstance().verifyPhoneOTP(withStateID: "id", otp: "otp", completionHandler: {(response,error) in
                if let e = error{
                    print(e.localizedDescription)
                }else{
                    print("Success")
                }
        })
      
    }
```

## Resend Phone OTP
This endpoint resends an OTP to your phone Number.
   
```
   func ResendPhoneOtp()
       {
        
        AuthenticationAPI.authInstance().resendPhoneOTP(withStateID: "id", language: "language", completionHandler: {(response,error) in
                if let e = error{
                    print(e.localizedDescription)
                }else{
                    print("Success")
                }
        })
    }
     
```

## JWKS
This endpoint provides a valid public key set for the user to validate their tokens

```
func Jwks(){
        
        AuthenticationAPI.authInstance().jwks({(response,error)in
       
                if let e = error{
                    print(e.localizedDescription)
                }else{
                    print("Success")
                }
        })

    }

```

## Validate Token

This endpoint Validates the JWT Token

```
    AuthenticationAPI.authInstance().validateToken("<token>", completionHandler: {(response, error)in
        if let err = error {
            print(err.localizedDescription)
        } else {
            print("Success")
        }
    })
```

## Refresh Token

This endpoint generates a set of new tokens by using refresh token

```
func RefreshToken()
    {
        AuthenticationAPI.authInstance().refreshAccessToken(withRefreshToken: "token", completionHandler: {(response, error)in
            if let err = error {
                print(err.localizedDescription)
            }else{
                print("Sucess")
            }
        })
    }
```


## MojoAuth SDK Native Social Login Methods

### Facebook native login

You don't need to download and integrate the Facebook SDK with your project. It is distributed as a dependency with MojoAuth SDK. Just make sure your Info.plist

*If you are using our demo, then go to our  AppDelegate.swift and set useFacebookNative to true to display our native facebook ui.*

If you are making your app, then proceed to add these lines of codes.

and you are calling application:openURL:sourceApplication:annotation in your AppDelegate.m.


```
@UIApplicationMain class AppDelegate: UIResponder, UIApplicationDelegate {

...

func application(_ app: UIApplication, open url: URL, options: [UIApplicationOpenURLOptionsKey : Any] = [:]) -> Bool{
        return MojoAuthSDK.sharedInstance().application(app, open: url, sourceApplication: options[UIApplicationOpenURLOptionsKey.sourceApplication] as? String, annotation: options[UIApplicationOpenURLOptionsKey.annotation])
 }
...

}
```

*Replace the values with your Facebook App ID and Display name from your App Settings page in Facebook Developer portal(https://developers.facebook.com/)*


```
MojoAuthSocialLoginManager.sharedInstance().nativeFacebookLogin(withPermissions: ["facebookPermissions": ["public_profile"]], in: self, completionHandler: {( data, error) -> Void in

    if let err = error {
        print(err.localizedDescription)
    } else {
        print("Successfully logged in with facebook")
    }
})
```

### Google native login

Google Native Login is done through Google SignIn Library since this is a static library and has problems when you are using CocoaPods with uses_frameworks!, you have to manually install the SDK.

Follow these steps:

1.For Google SignIn, you would need a configuration file GoogleServices-Info.plist. You can generate one following the steps here.

2.Drag the GoogleService-Info.plist file you just downloaded into the root of your Xcode project and add it to all targets.

3.Google SignIn requires a custom URL Scheme to be added to your project. Add it to your Info.plist file.

4.Add Google Sign In by following the https://developers.google.com/identity/sign-in/ios/sign-in

5.If you are using our demo, go to our AppDelegate.swift and set useGoogleNative to true to display our native google ui. Our demo already contain all the necessary code to perform native Google Sign in, you just have to uncomment any instance of /* Google Native SignIn `<code block>` */

6.If you are making your own app, proceed to add these lines of codes. You can also see our demo to see the native google sign in action!

7.Add Google SignIn Library to your Podfile. pod 'Google/SignIn'

8.Now change your App Delegate's open URL to handle both google native sign in and our default logins.


```
func application(_ app: UIApplication, open url: URL, options: [UIApplicationOpenURLOptionsKey : Any] = [:]) -> Bool
    {
        var canOpen = false
        canOpen = (canOpen || GIDSignIn.sharedInstance().handle(url, sourceApplication: options[UIApplicationOpenURLOptionsKey.sourceApplication] as! String, annotation: options[UIApplicationOpenURLOptionsKey.annotation]))

        canOpen = (canOpen || MojoAuthsSDK.sharedInstance().application(app, open: url, sourceApplication: options[UIApplicationOpenURLOptionsKey.sourceApplication] as? String, annotation: options[UIApplicationOpenURLOptionsKey.annotation]))

        return canOpen
    }
```

9.You have to exchange the Google token with MojoAuth Token. Call the following function in the SignIn delegate method after successful sign in.


```
func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {

        if let err = error
        {
            print("Error: \(err.localizedDescription)")
        }
        else
        {
            let googleToken: String = user.authentication.accessToken
            let refreshToken: String = user.authentication.refreshToken
            let clientID: String = user.authentication.clientID
            if let navVC = self.window?.rootViewController as? UINavigationController,
            let currentVC = navVC.topViewController
            {
            //@param socialAppName  should have unique social app name as a provider in case of multiple social apps for the same provider (eg. google_<social app name> )

                MojoAuthSocialLoginManager.sharedInstance().convertGoogleToken(googleToken,google_refresh_token:refreshToken, google_client_id:clientID, in:currentVC, completionHandler: {( data ,  error) -> Void in
                NotificationCenter.default.post(name: Notification.Name("userAuthenticatedFromNativeGoogle"), object: nil, userInfo: ["data":data as Any,"error":error as Any])
                })
            }
        }
    }
```

10.As the final step, add the google native signOut on your logout button.


```
GIDSignIn.sharedInstance().signOut()
```
