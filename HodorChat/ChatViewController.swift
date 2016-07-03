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
    var incomingBubble: JSQMessagesBubbleImage!
    var outgoingBubble: JSQMessagesBubbleImage!
    var avatars = [String: JSQMessagesAvatarImage]()
    var messages = [JSQMessage]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hideImageBtn()
        self.navigationItem.title = "Hodor"
        
        let bubleFactory = JSQMessagesBubbleImageFactory()
        incomingBubble = bubleFactory.incomingMessagesBubbleImageWithColor(UIColor.jsq_messageBubbleBlueColor())
        outgoingBubble = bubleFactory.incomingMessagesBubbleImageWithColor(UIColor.jsq_messageBubbleLightGrayColor())
        
    }
    
    override func collectionView(collectionView: JSQMessagesCollectionView!, messageDataForItemAtIndexPath indexPath: NSIndexPath!) -> JSQMessageData! {
        
        return messages[indexPath.row]
    }
    
    override func collectionView(collectionView: JSQMessagesCollectionView!, messageBubbleImageDataForItemAtIndexPath indexPath: NSIndexPath!) -> JSQMessageBubbleImageDataSource! {
        let message =  messages[indexPath.row]
        
        if message.senderId == senderId{
            return outgoingBubble
        }
        return incomingBubble
    }
    
    override func collectionView(collectionView: JSQMessagesCollectionView!, avatarImageDataForItemAtIndexPath indexPath: NSIndexPath!) -> JSQMessageAvatarImageDataSource! {
        let message = messages[indexPath.row]
        return avatars[message.senderId]
    }
    
    
    
    
    
    func createAvatar(senderID: String, SenderDisplayName: String, Color: UIColor){
        if avatars[senderId] == nil{
            let initials = senderDisplayName.substringToIndex(senderDisplayName.startIndex.advancedBy(min(2, senderDisplayName.characters.count)))
            
            let avatar = JSQMessagesAvatarImageFactory.avatarImageWithUserInitials(initials, backgroundColor: Color, textColor: UIColor.blackColor(), font: UIFont.systemFontOfSize(14), diameter: UInt(kJSQMessagesCollectionViewAvatarSizeDefault))
            
            avatars[senderId] = avatar
        }
    }
    
    
    func hideImageBtn(){
        self.inputToolbar.contentView.leftBarButtonItem.hidden = true
        self.inputToolbar.contentView.leftBarButtonItemWidth = 0
    }
}
