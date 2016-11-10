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
    
    struct menuItem {
        var img = UIImage()
        var name = String()
    }
    
    var menuItems: Array<menuItem>!
    
    override func viewDidLoad() {
        super.viewDidLoad()

       
        var firstName : String = NSUserDefaults.standardUserDefaults().valueForKey("firstName") as! String
        firstName = firstName + " "
        
        let lastName : String = NSUserDefaults.standardUserDefaults().valueForKey("lastName") as! String
        let fullName : String = firstName.stringByAppendingString(lastName)
        usernameButton.setTitle(fullName, forState: .Normal)
        
        navigationTableView.registerNib(UINib(nibName: "MenuItem_TableViewCell", bundle: nil), forCellReuseIdentifier: "NavCell")
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
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menuItems.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = navigationTableView.dequeueReusableCellWithIdentifier("NavCell", forIndexPath: indexPath) as! MenuItem_TableViewCell
        
        cell.configureCell(menuItems[indexPath.row])
        return cell
    }
    


// Mark: Table View Delegate

    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        print("Clicked menuItem")
        let vc_name = menuItems[indexPath.row].name
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewControllerWithIdentifier(vc_name)
        //self.presentViewController(controller, animated: true, completion: nil)
        
        
        let transition = CATransition()
        transition.duration = 0.2
        transition.type = kCATransitionPush
        transition.subtype = kCATransitionFromRight
        view.window!.layer.addAnimation(transition, forKey: kCATransition)
        presentViewController(controller, animated: false, completion: nil)
        
    }
    
}


