//
//  Favor.swift
//  U O ME
//
//  Created by Rohit Saigal on 11/8/16.
//  Copyright © 2016 Collin Walther, Rohit Saigal. All rights reserved.
//

import UIKit

class Favor: NSObject {
    let value:NSInteger
    let recipient:User
    let favorDescription: NSString
    let sender:User
    var status:String
    let favorid:Int64
    init(value:NSInteger,recipient:User,favorDescription:NSString,sender:User,favorid:Int64,status:String){
        self.value=value
        self.recipient=recipient
        self.favorDescription=favorDescription
        self.sender=sender
        self.favorid=favorid
        self.status=status
    }
    func getRecipientName()->String{
        return self.recipient.getFullName()
    }
    func getSenderName()->String{
        return self.sender.getFullName()
    }
}
