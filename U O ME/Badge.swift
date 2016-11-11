//
//  Badge.swift
//  U O ME
//
//  Created by Collin Walther on 11/10/16.
//  Copyright © 2016 Collin Walther, Rohit Saigal. All rights reserved.
//

import UIKit

class Badge: NSObject {

    let badgeImage: UIImage
    let badgeLabelText: String
    let badgeProgressView: UIProgressView
    let badgeDescription : String
    
    
    init(badgeImage: UIImage, badgeLabelText: String, badgeProgressView: UIProgressView, badgeDescription: String){
        
        self.badgeImage = badgeImage
        self.badgeLabelText = badgeLabelText
        self.badgeProgressView = badgeProgressView
        self.badgeDescription = badgeDescription
        
    }
    
    class func getBadgeList() -> Array<Badge>{
        return [Badge(badgeImage: UIImage(named: "invite_icon 30x30.png")!, badgeLabelText: "Badge Name", badgeProgressView: UIProgressView(), badgeDescription: "desc")]
        
    
        
    }
    
}
