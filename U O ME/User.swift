//
//  User.swift
//  U O ME
//
//  Created by Rohit Saigal on 11/8/16.
//  Copyright © 2016 Collin Walther, Rohit Saigal. All rights reserved.
//

import UIKit

class User: NSObject {
    let id:Int64
    let first: String
    let last:String
    let level: NSInteger
    let picture: UIImage
    let favorPoints:NSInteger
    var email: String

    var pendingFavors=[Favor]()
    var requestedFavors=[Favor]()
    var favorHistory=[Favor]()
    init(first: String, last:String, level:NSInteger, image:UIImage, points:NSInteger, email:String,id:Int64){
        self.first=first
        self.last=last
        self.level=level
        self.picture=image
        self.favorPoints=points
        self.email=email
        self.id=id
        
    }
}
