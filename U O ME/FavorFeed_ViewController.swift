//
//  FavorFeed_ViewController.swift
//  U O ME
//
//  Created by Collin Walther on 11/2/16.
//  Copyright © 2016 Collin Walther, Rohit Saigal. All rights reserved.
//

import UIKit

class FavorFeed_ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, NavigationMenu_ViewControllerDelegate {
    
    @IBOutlet var wholeView: UIView!
    @IBOutlet weak var favorTable: UITableView!
    var friends:[User]!
    var user:User!
    var newsFeed:[Favor]!
    var idx:Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        friends=uomeDB.instance.getUsers()
        favorTable.register(UINib(nibName: "Favor_TableViewCell", bundle: nil), forCellReuseIdentifier: "FavorCell")
        
        // Do any additional setup after loading the view.
        
        self.addNavigationMenu()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    
    // MARK: Favor tableview
    func tableView(_ tableView:UITableView, numberOfRowsInSection section:Int) -> Int
    {
        if let value=user{
            
            print("Val"+String(value.favorHistory.count))
            return value.pendingFavors.count
        }
        return 1
    }
    @IBAction func acceptTask(_ sender: UIButton) {
        /// implement accept a task
        print("click1111")
        let touchpoint: CGPoint = sender.convert(CGPoint.zero, to: self.favorTable)
        let buttonIndexPath: NSIndexPath = self.favorTable.indexPathForRow(at: touchpoint)! as NSIndexPath
        idx=buttonIndexPath.row
//        var touchPoint = sender.convert(CGPoint.zero, to: favorTable)
//        // maintable --> replace your tableview name
//        var x:NSIndexPath
//        x=
//        print(clickedButtonIndexPath.Row)
        performSegue(withIdentifier: "FavorToAccept", sender: self)
//
////        if (sender.tag == 0)
//        {
//            
//            user?.pendingFavors.remove(at: sender.tag)
//         
//        }
    }
    
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        
        
        if let value=user{
            let cell = favorTable.dequeueReusableCell(withIdentifier: "FavorCell", for: indexPath as IndexPath) as! Favor_TableViewCell
            let currFavor=value.pendingFavors[indexPath.row]
            cell.topLabel.text = currFavor.sender.first+" is requesting "+String(currFavor.value) + " points from " + currFavor.recipient.first+" for:"
            
            cell.favorTitleLabel.text = currFavor.favorDescription as String
            cell.acceptButton.tag=indexPath.row
            cell.recipient=value
            cell.acceptButton.addTarget(self, action: #selector(FavorFeed_ViewController.acceptTask(_:)), for: .touchUpInside)
            
            return cell
            
        }
        else{
            let cell = favorTable.dequeueReusableCell(withIdentifier: "FavorCell", for: indexPath as IndexPath) as! Favor_TableViewCell
            
            cell.topLabel.text = "collin earned 3 points from rohit for:"
            cell.favorTitleLabel.text = "Doing homework"
            
            
            
            return cell
        }
    }
    
    func tableView( _ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 300
    }
    
    func tableView( _ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    
    
    
    
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

//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if(segue.identifier == "FavorToAccept"){
//            print("favor to Accept")
//            let userProfile = (segue.destination as! Accept_ViewController)
//            userProfile.user = user
//            userProfile.friends=friends
//            userProfile.newsFeed=newsFeed
//            userProfile.idx=idx
//        }
//    }
//    
    
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
