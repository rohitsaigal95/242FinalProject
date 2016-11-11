//
//  MessageComposer.swift
//  U O ME
//
//  Created by Collin Walther on 11/9/16.
//  Copyright © 2016 Collin Walther, Rohit Saigal. All rights reserved.
//

// This code is taken from the link below.
// Why reinvent the wheel?
// https://www.andrewcbancroft.com/2014/10/28/send-text-message-in-app-using-mfmessagecomposeviewcontroller-with-swift/


import MessageUI



class MessageComposer: NSObject, MFMessageComposeViewControllerDelegate {
    
    let textMessageRecipients : [String]
    init(number: String) {
        self.textMessageRecipients = [number]
    }
    
    // A wrapper function to indicate whether or not a text message can be sent from the user's device
    func canSendText() -> Bool {
        return MFMessageComposeViewController.canSendText()
    }
    
    // Configures and returns a MFMessageComposeViewController instance
    func configuredMessageComposeViewController() -> MFMessageComposeViewController {
        let messageComposeVC = MFMessageComposeViewController()
        messageComposeVC.messageComposeDelegate = self  //  Make sure to set this property to self, so that the controller can be dismissed!
        messageComposeVC.recipients = textMessageRecipients
        messageComposeVC.body = "Do your friends owe you one? Download U O ME!"
        return messageComposeVC
    }
    
    // MFMessageComposeViewControllerDelegate callback - dismisses the view controller when the user is finished with it
    func messageComposeViewController(_ controller: MFMessageComposeViewController, didFinishWith result: MessageComposeResult) {
        controller.dismiss(animated: true, completion: nil)
    }
}
