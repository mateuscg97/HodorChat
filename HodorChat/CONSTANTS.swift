//
//  CONSTANTS.swift
//  HodorChat
//
//  Created by Mateus Da Costa Goncalves on 02/07/16.
//  Copyright © 2016 Mateus Da Costa Goncalves. All rights reserved.
//

import Foundation
import Firebase

let FIREBASE = Firebase(url: "https://hodorchat.firebaseio.com")
let FIREBASE_USERS = FIREBASE.childByAppendingPath("Users")
let FIREBASE_Chat = FIREBASE.childByAppendingPath("Chat")
let LOGIN_SEGUE = "login"