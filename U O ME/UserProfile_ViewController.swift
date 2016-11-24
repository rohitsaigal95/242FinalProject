//
//  UserProfile.swift
//  U O ME
//
//  Created by Rohit Saigal on 11/2/16.
//  Copyright © 2016 Collin Walther, Rohit Saigal. All rights reserved.
//

import UIKit


class UserProfile: UIViewController, UITableViewDelegate, UITableViewDataSource,NavigationMenu_ViewControllerDelegate {
    
    
    @IBOutlet weak var wholeView: UIView!
    
    @IBOutlet weak var userPicture: UIImageView!
    @IBOutlet weak var favorHistory: UITableView!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var userLevel: UILabel!
    var user:User!
    var value:User!
    var newsFeed:[Favor]!
    
    
    @IBOutlet weak var badge1ImageView: UIImageView!
    @IBOutlet weak var badge1Label: UILabel!
    @IBOutlet weak var badge2ImageView: UIImageView!
    @IBOutlet weak var badge2Label: UILabel!
    @IBOutlet weak var badge3ImageView: UIImageView!
    @IBOutlet weak var badge3Label: UILabel!
    @IBOutlet weak var badge4ImageView: UIImageView!
    @IBOutlet weak var badge4Label: UILabel!
    var friends=uomeDB.instance.getUsers()
    
    /*
 set up a fake data base of friends */
    
    //    var friends=[User(name: "Collin", level: 0, image:UIImage(named:"profile_icon  30x30.png")!, points:0,email:"cwalthe2@illinois.edu"),User(name: "Nitish", level: 0, image:UIImage(named:"profile_icon  30x30.png")!, points:0,email:"nitishistheman@studmuffin.edu"),User(name: "Jayme", level: 0, image:UIImage(named:"profile_icon  30x30.png")!, points:0,email:"jayms_parker@bentley.edu")]
    
    override func viewDidLoad() {
        super.viewDidLoad()        
        
        /* set up a user, unless user has already been initialized in which case it is overwritten */
        
//        user=User(name: "Rohit", level: 0, image:UIImage(named:"profile_icon  30x30.png")!, points:0,email:"rohitnsaigal@gmail.com")
//        let rideHome=Favor(sender:user,value: 2, recipient: friends[0], favorDescription: "Can you give me a ride home from grainger?")
//            user.favorHistory.append(rideHome)
//        
        
        
        //print(user.favorHistory.count)
        userName.text=user.first + " " + user.last
        userLevel.text="Level: " + String(user.level)
        userPicture.image = user.picture
        
        
        
        //favorHistory.registerClass(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
        
        
        favorHistory.register(UINib(nibName: "UserHistory_TableViewCell", bundle: nil), forCellReuseIdentifier: "FavorCell")
        // Do any additional setup after loading the view, typically from a nib.
        self.addNavigationMenu()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func requestFavor(_ sender: Any) {
        
        performSegue(withIdentifier: "ProfileToRequest", sender: self)
    }
    func tableView(_ tableView:UITableView, numberOfRowsInSection section:Int) -> Int
    {
        print(user.favorHistory.count)
        return user.favorHistory.count
        
    }
    
    /*
    defines the cell that will be shown in a user's profile 
 */
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = favorHistory.dequeueReusableCell(withIdentifier: "FavorCell", for: indexPath as IndexPath) as! UserHistory_TableViewCell
 
         let currFavor=user.favorHistory[indexPath.row]
        
        cell.favorFacts.text = currFavor.recipient.first+" earned "+String(currFavor.value) + " points from " + user.first+" for:"
        
        cell.favorInfo.text = currFavor.favorDescription as String
        
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 75
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    
    
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "ProfileToRequest"){
            let requestFavor = (segue.destination as! RequestFavor)
            print("reach"+String(friends.count))
            
            requestFavor.value = user
            requestFavor.friends=friends
            requestFavor.newsFeed=newsFeed
        }
        if(segue.identifier == "ProfileToFavorFeed"){
            print("is called")
            let favorFeed = (segue.destination as! FavorFeed_ViewController)
            favorFeed.user = user
            favorFeed.friends=friends
            favorFeed.newsFeed=newsFeed
        }
        
    }
/*
    @IBAction func requestFavor(sender: UIButton) {
        let storyboard = UIStoryboard(name: "User Profile", bundle:nil)
        let controller = storyboard.instantiateViewControllerWithIdentifier("Request Favor")
        self.presentViewController(controller,animated:true,completion:nil)
        
        
     
    }
*/
    // MARK: Navigation Menu
    
    @IBAction func navigationClick(_ sender: AnyObject) {
        
        if (self.wholeView.frame.origin.x == 0){
            showNavigationMenu()
        }
        else{
            hideNavigationMenu()
        }
    }
    
    
    func addNavigationMenu() {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "NavigationMenuViewController")
        self.view.insertSubview(controller.view, at: 0)
        
        addChildViewController(controller)
        controller.didMove(toParentViewController: self)
        
    }
    
    func showNavigationMenu() {
        UIView.animate(withDuration: 0.35, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0, options: UIViewAnimationOptions(), animations: { self.wholeView.frame.origin.x = 250}, completion: nil)
        
    }
    
    func hideNavigationMenu() {
        UIView.animate(withDuration: 0.25, animations: {
            self.wholeView.frame.origin.x = 0
            
        })
    }
    
    
    
    
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
}




