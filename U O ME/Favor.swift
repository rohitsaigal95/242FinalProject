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
    
    init(sender:User,value:NSInteger,recipient:User,favorDescription:NSString){
        self.sender=sender
        self.value=value
        self.recipient=recipient
        self.favorDescription=favorDescription
        
        
    }
    
    
    
}
