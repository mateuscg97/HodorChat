//
//  ChatViewController.swift
//  HodorChat
//
//  Created by Mateus Da Costa Goncalves on 03/07/16.
//  Copyright © 2016 Mateus Da Costa Goncalves. All rights reserved.
//

import UIKit
import JSQMessagesViewController

class ChatViewController: JSQMessagesViewController {

    var user: Dictionary<String, String>?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        hideImageBtn()
        print(user)
        print(self.senderId)
        print(self.senderDisplayName)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func hideImageBtn(){
        self.inputToolbar.contentView.leftBarButtonItem.hidden = true
        self.inputToolbar.contentView.leftBarButtonItemWidth = 0
    }
}
