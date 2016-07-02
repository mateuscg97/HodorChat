//
//  ViewController.swift
//  HodorChat
//
//  Created by Mateus Da Costa Goncalves on 02/07/16.
//  Copyright © 2016 Mateus Da Costa Goncalves. All rights reserved.
//

import UIKit
import Firebase
import FBSDKCoreKit
import FBSDKLoginKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        loginFacebook()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func loginFacebook(){
        let facebookLogin = FBSDKLoginManager()
        facebookLogin.logInWithReadPermissions(["public_profile", "email", "user_friends"], handler: {
            
            (facebookResult, facebookError) -> Void in
            if facebookError != nil {
                
                print("Facebook login failed. Error \(facebookError)")
            } else if facebookResult.isCancelled {
                
                print("Facebook login was cancelled.")
            } else {
                
                let accessToken = FBSDKAccessToken.currentAccessToken().tokenString
                FIREBASE.authWithOAuthProvider("facebook", token: accessToken,
                    withCompletionBlock: { error, authData in
                        if error != nil {
                            
                            print("Login failed. \(error)")
                        } else {
                            
                            print("Logged in! \(authData)")
                            self.getFacebookProfile()
                        }
                })
            }
        })
    }
    
    func getFacebookProfile(){
        /*id, name, first_name, last_name, age_range, link, gender, locale, timezone,updated_time, verified*/
        
        if((FBSDKAccessToken.currentAccessToken()) != nil){
            FBSDKGraphRequest(graphPath: "me", parameters: ["fields": "id, name, first_name, last_name, email, gender"]).startWithCompletionHandler({ (connection, result, error) -> Void in
                if (error == nil){
                    print(result)
                }
            })
        }
    }
    
}

