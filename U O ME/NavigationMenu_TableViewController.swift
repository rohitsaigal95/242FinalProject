//
//  NavigationMenu_ViewController.swift
//  U O ME
//
//  Created by Collin Walther on 11/3/16.
//  Copyright © 2016 Collin Walther, Rohit Saigal. All rights reserved.
//

import UIKit

class NavigationMenu_ViewController: UIViewController {

    @IBOutlet weak var navigationTableView: UITableView!
    
    struct menuItem {
        var img = UIImage()
        var name = String()
    }
    
    var menuItems: Array<menuItem>!
    
    override func viewDidLoad() {
        super.viewDidLoad()

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
            menuItem(img: UIImage(named: "favor_icon 30x30.png")!, name: "Favor Feed")
            
        ]
        
    }
}


    // MARK: - Table view data source

extension NavigationMenu_ViewController: UITableViewDataSource {
    
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menuItems.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = navigationTableView.dequeueReusableCellWithIdentifier("NavCell", forIndexPath: indexPath) as! navigationCell
        cell.configureCell(menuItems[indexPath.row])
        return cell
    }
    
}






class navigationCell : UITableViewCell {
    
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var menuLabel: UILabel!
    
    func configureCell(menuItem: NavigationMenu_ViewController.menuItem) {
        imgView.image = menuItem.img
        menuLabel.text = menuItem.name
    }
    
    
}
