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
import JSQMessagesViewController

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func facebookLogin(sender: AnyObject) {
        loginFacebook()
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
                            self.getFacebookProfile(authData)
                        }
                })
            }
        })
    }
    
    func getFacebookProfile(authData: FAuthData){
        /*id, name, first_name, last_name, age_range, link, gender, locale, timezone, updated_time, verified*/
        if((FBSDKAccessToken.currentAccessToken()) != nil){
            
            FBSDKGraphRequest(graphPath: "me", parameters: ["fields": "id, name, first_name, last_name, email, gender"]).startWithCompletionHandler({ (connection, result, error) -> Void in
                if (error == nil){
                    
                    if let resultDict = result as? Dictionary<String, String>{
                        
                        self.performSegueWithIdentifier(LOGIN_SEGUE, sender: resultDict)
                        FIREBASE_USERS.childByAppendingPath(authData.uid).setValue(result)
                    }
                }
            })
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == LOGIN_SEGUE{
            
            if let navVC = segue.destinationViewController as? UINavigationController{
                
                if let chatVC = navVC.viewControllers.first as? ChatViewController{
                    
                    if let senderDict = sender as? Dictionary<String, String>{
                        
                        chatVC.senderDisplayName = senderDict["name"]
                        chatVC.senderId = FIREBASE.authData.uid
                        chatVC.user = senderDict
                    }
                }
            }
        }else{
            print("segue.identifier wrong")
        }
    }
}

