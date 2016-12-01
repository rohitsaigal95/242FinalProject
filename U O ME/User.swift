//
//  User.swift
//  U O ME
//
//  Created by Rohit Saigal on 11/8/16.
//  Copyright © 2016 Collin Walther, Rohit Saigal. All rights reserved.
//

import UIKit

class User: NSObject {
    let first: String
    let last: String
    let email:String
    let level: NSInteger
    let picture: UIImage
    let password:String
    let favorPoints:NSInteger
    var pendingFavors=[Favor]()
    var requestedFavors=[Favor]()
    var favorHistory=[Favor]()
    var toApprove=[Favor]()
    var id:Int64
    var friends:[User]?
    var friendid:String
    init(first: String,last: String,email:String,pass:String, level:NSInteger, image:UIImage, points:NSInteger,id:intmax_t,friendid:String){
        self.first=first
        self.last=last
        self.level=level
        self.picture=image
        self.favorPoints=points
        self.id = id
        self.email=email
        self.password=pass
        self.friends=[]
        self.friendid=friendid
    
}
    func getFullName() -> String {
        return self.first + " " + self.last
    }
    public static func getUserFromDB(email:String) -> User?{
        let users = uomeDB.instance.getUsers()
        
                for u in users{
                    print(u.first)
                    switch(u.email.caseInsensitiveCompare(email))
        
                    {
                    case .orderedSame:
                        
                        return u
                    default:
                        break
                    }
                }
        
        return nil
    }
    func fillFriends(){
        let users=uomeDB.instance.getUsers()
        let nums=friendid.components(separatedBy: ",")
        print(friendid)
       // var = Set<String>()
        for u in users{
            
            for num in nums{
                print(String(u.id)+" , "+num)
                if (String(u.id)==num){
                    u.getPendingAndRequestedFavors()
                    print("added friend")
                    friends?.append(u)
                }
            }
        }
        
    }
    public static func getUserFromName(name:String) -> User?{
    let users=uomeDB.instance.getUsers()
        for u in users{
            if(u.getFullName()==name){
                return u
            }
        }
        
        return nil
    }
    func getNewsFeed()->[Favor]?{
        var newsFeed:[Favor]
        newsFeed=[]
        var temp = friends
        temp?.append(self)
        for f in temp!{
            for fav in f.pendingFavors{
                newsFeed.append(fav)
            }
        }
        return newsFeed
        
    }
    func getPendingAndRequestedFavors(){
        
        let favors = uomeDB.instance.getFavors()
        
        for f in favors{
            if(getFullName()==f.getRecipientName()){
                pendingFavors.append(f)
                
            }
            if(getFullName()==f.getSenderName()){
                requestedFavors.append(f)
            }
        }
        
        
        
    }
    public static func getFavorsThatAre(status:String,arr:[Favor])->[Favor]?{
        var ret = [Favor]()
        if(status=="incomplete"){
            for favor in arr{
                if(favor.status=="incomplete"){
                    ret.append(favor)
                }
            }
            
        }
        else{
            for favor in arr{
                if(favor.status=="complete"){
                    ret.append(favor)
                }
            }
            
            
            
        }
        return ret
    }
    
    public static func updateFavorStatus(arr:[Favor])->[Favor]{
        let db=uomeDB.instance.getFavors()
        
        for f in arr{
            for fav in db{
                
                if (f.favorid==fav.favorid){
                    print(fav.status)
                    
                    print(f.status+","+(f.favorDescription as String)+","+fav.status)
                    f.status=fav.status
                }
            }
            
            
        }
        return arr
    }
    func updatePendingFavors(){
        let db=uomeDB.instance.getFavors()
        
        for favor in db{
            for i in 0...pendingFavors.count-1{
                if ( pendingFavors[i].favorid==favor.favorid ){
                    pendingFavors[i].status=favor.status
                }
            }
        }
    }
}
