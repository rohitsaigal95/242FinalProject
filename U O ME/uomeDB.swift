//
//  uome_db.swift
//  U O ME
//
//  Created by Rohit Saigal on 11/20/16.
//  Copyright © 2016 Collin Walther, Rohit Saigal. All rights reserved.
//

import Foundation
import SQLite
import UIKit
//database class that implements a user and favor table with functions to add users and favors 
class uomeDB {
    static let instance = uomeDB()
    let db:Connection?
    
    private let users=Table("users")
    private let favors=Table("favors")
    
    private let recipient=Expression<String>("recipient")
    private let sender=Expression<String>("sender")
    private let value = Expression<Int64>("value")
    private let favorDescription=Expression<String>("favor")
    private let favorId=Expression<Int64>("favorId")
    
    private let level = Expression<Int64>("level")
    private let first = Expression<String?>("first")
    private let last = Expression<String?>("last")
    private let email = Expression<String>("email")
    private let password=Expression<String>("password")
    private let id = Expression<Int64>("id")
    private let friendNumbers=Expression<String>("friends")
    private let status=Expression<String>("status")
    init(){
        
        
        //let path = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
        do{
            db=try Connection("/Users/rohitsaigal/Desktop/database_files/UOMEDB.db")
            print("database OPENED :) :) ")
        }catch{
            db=nil
            print("cant open db")
        }
        
        
        createUserTable()
        createFavorTable()
    }
    
    /*
 
 create a user table
 */
    func createUserTable() {
        do {
            try db!.run(users.create(ifNotExists: true) { table in
                table.column(id, primaryKey: true)
                table.column(first)
                table.column(last)
                table.column(email, unique: true)
                table.column(level)
                table.column(password)
                table.column(friendNumbers)
            })
            print("created User table")
        } catch {
            print("Unable to create table")
        }
    }
    /*
     
     create a favor table
     */
    func createFavorTable() {
        do {
            try db!.run(favors.create(ifNotExists: true) { table in
                table.column(favorId, primaryKey: true)
                table.column(recipient)
                table.column(sender)
                table.column(favorDescription)
                table.column(value)
                table.column(status)
            })
            print("created Favor table")
        } catch {
            print("Unable to create table")
        }
    }
    /*
     add a user into the table
     */
    func addUsers(newUser:User) -> Int64? {
        do {
            let insert = users.insert(first <- newUser.first,last <- newUser.last, email <- newUser.email, level <- Int64(newUser.level),password <- newUser.password,friendNumbers <- newUser.friendid)
            print(insert.asSQL())
            let id = try db!.run(insert)
            
            print("Insert succeeded")
            return id
        } catch {
            print("Insert failed")
            return -1
        }
    }
    /*
   get list of users in databse
     */
    func getUsers() -> [User] {
        var users = [User]()
        

        
        
        do {
            for user in try db!.prepare(self.users) {
                users.append(User(first: user[first]!,last: user[last]!,email: user[email],pass:user[password], level: NSInteger(user[level]), image:UIImage(named:"profile_icon  30x30.png")!, points: 0,id:user[id],friendid:user[friendNumbers]))
                
            }
        } catch {
            print("Select failed")
        }
        
        return users
    }
    /*
     
     get a list of favors in database 
     
     */
    func getFavors() -> [Favor] {
        var favors = [Favor]()
        
        
        
        
        do {
            for favor in try db!.prepare(self.favors) {
                favors.append(Favor(value: NSInteger(favor[value]), recipient: User.getUserFromName(name: favor[recipient])!, favorDescription: favor[favorDescription] as NSString, sender: User.getUserFromName(name: favor[sender])!,favorid:favor[favorId],status:favor[status]))
                
            }
        } catch {
            print("Select failed")
        }
        
        return favors
    }
    
    /*
add a favor into the favor table
     */
    func addFavor(newFavor:Favor) -> Int64? {
        do {
            let insert = favors.insert(recipient <- newFavor.getRecipientName(),sender<-newFavor.getSenderName(),favorDescription <- newFavor.favorDescription as String, value <- Int64(newFavor.value),status<-newFavor.status)
            print(insert.asSQL())
            let id = try db!.run(insert)
            
            print("Insert Favor succeeded")
            return id
        } catch {
            print("Insert failed")
            return -1
        }
    }
    /*
     
     update the csv of friends for a user when adding a friend
     */
    func updateUsersFriends(cid:Int64, newNum: String) -> Bool {
        let user = users.filter(id == cid)
        do {
            let update = user.update([
          friendNumbers <- newNum
                ])
            if try db!.run(update) > 0 {
                return true
            }
        } catch {
            print("Update failed: \(error)")
        }
        
        return false
    }
    /*
     update the status of a favor "incomplete" or "complete"
     */
    func updateFavorStatus(fid:Int64, newStatus: String) -> Bool {
        let favor = favors.filter(favorId == fid)
        do {
            print("reachhhhh")
            let favor = favor.update([
                status <- newStatus
                ])
            if try db!.run(favor) > 0 {
                return true
            }
        } catch {
            print("Update failed: \(error)")
        }
        
        return false
    }
    
    
}
