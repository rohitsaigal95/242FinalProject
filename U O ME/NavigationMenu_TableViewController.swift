//
//  NavigationMenu_ViewController.swift
//  U O ME
//
//  Created by Collin Walther on 11/3/16.
//  Copyright © 2016 Collin Walther, Rohit Saigal. All rights reserved.
//

import UIKit

@objc
protocol NavigationMenu_ViewControllerDelegate {
    func addNavigationMenu()
    func showNavigationMenu()
    func hideNavigationMenu()
}

class NavigationMenu_ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var usernameButton: UIButton!
    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var navigationTableView: UITableView!
    var user:User!
    var friends:[User]!
    var newsFeed:[Favor]!
    
    struct menuItem {
        var img = UIImage()
        var name = String()
    }
    
    var menuItems: Array<menuItem>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       
        var firstName : String = UserDefaults.standard.value(forKey: "firstName") as! String
        firstName = firstName + " "
        
        let lastName : String = UserDefaults.standard.value(forKey: "lastName") as! String
        let fullName : String = firstName + lastName
        usernameButton.setTitle(fullName, for: UIControlState())
        
        navigationTableView.register(UINib(nibName: "MenuItem_TableViewCell", bundle: nil), forCellReuseIdentifier: "NavCell")
        configureMenuItems()
        navigationTableView.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func configureMenuItems() {
        menuItems = [
            menuItem(img: UIImage(named: "news_icon 30x30.png")!, name: "News Feed"),
            menuItem(img: UIImage(named: "favor_icon 30x30.png")!, name: "Favor Feed"),
            menuItem(img: UIImage(named: "invite_icon 30x30.png")!, name: "Invite Friends")
            
        ]
        
    }



    // MARK: - Table view data source
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menuItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = navigationTableView.dequeueReusableCell(withIdentifier: "NavCell", for: indexPath) as! MenuItem_TableViewCell
        
        cell.configureCell(menuItems[indexPath.row])
        return cell
    }
    


// Mark: Table View Delegate

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        print("Clicked menuItem")
        let vc_name = menuItems[indexPath.row].name
        switch vc_name {
        case "News Feed":
            performSegue(withIdentifier: "NavToNews", sender: self)
        case "Favor Feed":
            performSegue(withIdentifier: "NavToFavor", sender: self)
        default:
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let controller = storyboard.instantiateViewController(withIdentifier: vc_name)
            let transition = CATransition()
            transition.duration = 0.2
            transition.type = kCATransitionPush
            transition.subtype = kCATransitionFromRight
            view.window!.layer.add(transition, forKey: kCATransition)
            present(controller, animated: false, completion: nil)
        }
        
        //self.presentViewController(controller, animated: true, completion: nil)
        
        
        
      
        
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 108
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        
        if(segue.identifier == "NavToNews"){
            let transition = CATransition()
            transition.duration = 0.2
            transition.type = kCATransitionPush
            transition.subtype = kCATransitionFromRight
            view.window!.layer.add(transition, forKey: kCATransition)
//            present(controller, animated: false, completion: nil)
            
            print("called")
          
            let newsController = (segue.destination as! NewsFeed_ViewController)
            //let p=parent as! NewsFeed_ViewController
            if let p=parent as? NewsFeed_ViewController{
                newsController.newsFeed = p.newsFeed
                newsController.friends=p.friends
                newsController.user=p.user
            }
            else if let p=parent as? UserProfile{
                newsController.newsFeed = p.newsFeed
                newsController.friends=p.friends
                newsController.user=p.user
            }
            else if let p=parent as? FavorFeed_ViewController{
                newsController.newsFeed = p.newsFeed
                newsController.friends=p.friends
                newsController.user=p.user
            }
            
        }
        if(segue.identifier == "NavToProfile"){
            let transition = CATransition()
            transition.duration = 0.2
            transition.type = kCATransitionPush
            transition.subtype = kCATransitionFromRight
            view.window!.layer.add(transition, forKey: kCATransition)
            //            present(controller, animated: false, completion: nil)
            
            print("called")
            
            let newsController = (segue.destination as! UserProfile)
            //let p=parent as! NewsFeed_ViewController
            if let p=parent as? NewsFeed_ViewController{
                newsController.newsFeed = p.newsFeed
                newsController.friends=p.friends
                newsController.user=p.user
            }
            else if let p=parent as? UserProfile{
                newsController.newsFeed = p.newsFeed
                newsController.friends=p.friends
                newsController.user=p.user
            }
            else if let p=parent as? FavorFeed_ViewController{
                newsController.newsFeed = p.newsFeed
                newsController.friends=p.friends
                newsController.user=p.user
            }
            
        }
        if(segue.identifier == "NavToFavor"){
            let transition = CATransition()
            transition.duration = 0.2
            transition.type = kCATransitionPush
            transition.subtype = kCATransitionFromRight
            view.window!.layer.add(transition, forKey: kCATransition)
            //            present(controller, animated: false, completion: nil)
            
            print("called")
            
            let newsController = (segue.destination as! FavorFeed_ViewController)
            //let p=parent as! NewsFeed_ViewController
            if let p=parent as? NewsFeed_ViewController{
                newsController.newsFeed = p.newsFeed
                newsController.friends=p.friends
                newsController.user=p.user
            }
            else if let p=parent as? UserProfile{
                newsController.newsFeed = p.newsFeed
                newsController.friends=p.friends
                newsController.user=p.user
            }
            else if let p=parent as? FavorFeed_ViewController{
                newsController.newsFeed = p.newsFeed
                newsController.friends=p.friends
                newsController.user=p.user
            }
            
        }
        if(segue.identifier=="NavToAccept"){
            
            let transition = CATransition()
            transition.duration = 0.2
            transition.type = kCATransitionPush
            transition.subtype = kCATransitionFromRight
            view.window!.layer.add(transition, forKey: kCATransition)
            //            present(controller, animated: false, completion: nil)
            
            print("called")
            
            let acceptController = (segue.destination as! Accept_ViewController)
            //let p=parent as! NewsFeed_ViewController
            if let p=parent as? NewsFeed_ViewController{
                acceptController.newsFeed = p.newsFeed
                acceptController.friends=p.friends
                acceptController.user=p.user
            }
            else if let p=parent as? UserProfile{
                acceptController.newsFeed = p.newsFeed
                acceptController.friends=p.friends
                acceptController.user=p.user
            }
            else if let p=parent as? FavorFeed_ViewController{
                acceptController.newsFeed = p.newsFeed
                acceptController.friends=p.friends
                acceptController.user=p.user
            }

            
            
        }
    }
    
    
    
}


