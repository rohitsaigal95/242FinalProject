//
//  UserProfile.swift
//  U O ME
//
//  Created by Rohit Saigal on 11/2/16.
//  Copyright © 2016 Collin Walther, Rohit Saigal. All rights reserved.
//

import UIKit


class UserProfile: UIViewController {
    
    @IBOutlet weak var userPicture: UIImageView!
    @IBOutlet weak var favorHistory: UITableView!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var userLevel: UILabel!
    var user:User!
    var value:User!
    
    /*
 set up a fake data base of friends */
    var friends=[User(name: "Collin", level: 0, image:UIImage(named:"profile_icon  30x30.png")!, points:0),User(name: "Nitish", level: 0, image:UIImage(named:"profile_icon  30x30.png")!, points:0),User(name: "Jayme", level: 0, image:UIImage(named:"profile_icon  30x30.png")!, points:0)]
    
    override func viewDidLoad() {
        super.viewDidLoad()        
        
        /* set up a user, unless user has already been initialized in which case it is overwritten */
            user=User(name: "Rohit", level: 0, image:UIImage(named:"profile_icon  30x30.png")!, points:0)
            let rideHome=Favor(value: 2, recipient: friends[0], favorDescription: "Can you give me a ride home from grainger?")
            user.favorHistory.append(rideHome)
        
        if let currUser=value{
            user=currUser
        }
        
        print(user.favorHistory.count)
        userName.text=user.name
        userLevel.text="Level: " + String(user.level)
        userPicture=UIImageView(image: user.picture)
        
        
        
        //favorHistory.registerClass(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
        
        
        favorHistory.register(UINib(nibName: "UserHistory_TableViewCell", bundle: nil), forCellReuseIdentifier: "FavorCell")
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView:UITableView, numberOfRowsInSection section:Int) -> Int
    {
        print(user.favorHistory.count)
        return user.favorHistory.count
        
    }
    
    /*
    defines the cell that will be shown in a user's profile 
 */
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        let cell = favorHistory.dequeueReusableCell(withIdentifier: "FavorCell", for: indexPath as IndexPath) as! UserHistory_TableViewCell
 
         let currFavor=user.favorHistory[indexPath.row]
        
        cell.favorFacts.text = currFavor.recipient.name+" earned "+String(currFavor.value) + " points from " + user.name+" for:"
        
        cell.favorInfo.text = currFavor.favorDescription as String
        
        
        
        return cell
    }
    
    func tableView(tableView: UITableView, estimatedHeightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 75
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if(segue.identifier == "toRequest"){
            let requestFavor = (segue.destination as! RequestFavor)
            requestFavor.value = user
            requestFavor.friends=friends
        }
        if(segue.identifier == "ProfileToFavorFeed"){
            let favorFeed = (segue.destination as! FavorFeed_ViewController)
            favorFeed.value = user
            favorFeed.friends=friends
        }
    }
/*
    @IBAction func requestFavor(sender: UIButton) {
        let storyboard = UIStoryboard(name: "User Profile", bundle:nil)
        let controller = storyboard.instantiateViewControllerWithIdentifier("Request Favor")
        self.presentViewController(controller,animated:true,completion:nil)
        
        
        
    }
*/
}




