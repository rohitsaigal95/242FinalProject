//
//  NewsFeed_ViewController.swift
//  U O ME
//
//  Created by Collin Walther on 11/2/16.
//  Copyright © 2016 Collin Walther, Rohit Saigal. All rights reserved.
//

import UIKit


class NewsFeed_ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, NavigationMenu_ViewControllerDelegate{

    @IBOutlet weak var newsTable: UITableView!
    @IBOutlet var newsView: UIView!
    var user:User!
    var friends:[User]!
    var newsFeed:[Favor]!
    var currFeed:[Favor]!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        newsTable.register(UINib(nibName: "News_TableViewCell", bundle: nil), forCellReuseIdentifier: "NewsCell")

        addNavigationMenu()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        performSegue(withIdentifier: "SignUpToNews", sender: self)
        
        // Dispose of any resources that can be recreated.
    }
    
    
    
    
    // MARK: Favor tableview
    func tableView(_ tableView:UITableView, numberOfRowsInSection section:Int) -> Int
    {
        
    if let value=newsFeed{
        return value.count
        }
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        if let value=newsFeed{
            let cell = newsTable.dequeueReusableCell(withIdentifier: "NewsCell", for: indexPath) as! News_TableViewCell
            let curr=value[indexPath.row]
            cell.topLabel.text=(curr.sender.name + " earned/awared "+String(curr.value)+" points from " + curr.recipient.name)
            cell.favorTitleLabel.text=curr.favorDescription as String
            
            return cell
        }
        else{
            print("fack")
           
        let cell = newsTable.dequeueReusableCell(withIdentifier: "NewsCell", for: indexPath) as! News_TableViewCell
        
        if indexPath.row == 0{
            cell.topLabel.text = "Collin W. earned 3 points from Rohit S. for:"
            cell.favorTitleLabel.text = "Doing homework"
        }
        else{
            cell.topLabel.text = "Rohit S. awarded 6 points to Benjamin D. for:"
            cell.favorTitleLabel.text = "Picking up the pizza"
        }
        
        
        
        return cell
        }
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 88
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    


    // MARK: Navigation Menu
    
    @IBAction func navigationClick(_ sender: AnyObject) {
        
        if (self.newsView.frame.origin.x == 0){
            showNavigationMenu()
        }
        else{
            hideNavigationMenu()
        }
    }
    
    
    func addNavigationMenu() {
        //performSegue(withIdentifier: "NewsToNav", sender: self)
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "NavigationMenuViewController")
        self.view.insertSubview(controller.view, at: 0)
        
        addChildViewController(controller)
        controller.didMove(toParentViewController: self)
        
        
    }
    
    func showNavigationMenu() {
        UIView.animate(withDuration: 0.35, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0, options: UIViewAnimationOptions(), animations: { self.newsView.frame.origin.x = 250}, completion: nil)
        
    }
    
    func hideNavigationMenu() {
        UIView.animate(withDuration: 0.25, animations: {
            self.newsView.frame.origin.x = 0
            
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
    
    //pass data
    

    
    
    
}
