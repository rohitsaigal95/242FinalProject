//
//  AddFriend_ViewController.swift
//  U O ME
//
//  Created by Rohit Saigal on 11/30/16.
//  Copyright © 2016 Collin Walther, Rohit Saigal. All rights reserved.
//

import UIKit

class AddFriend_ViewController: UIViewController,UITableViewDelegate, UITableViewDataSource, NavigationMenu_ViewControllerDelegate {

   

    @IBOutlet weak var wholeView: UIView!
    @IBOutlet weak var addFriend: UITableView!
    var user:User?
    var users:[User]?
    override func viewDidLoad() {
        super.viewDidLoad()
        //users=uomeDB.instance.getUsers()
        //print("the num of users is " + String(describing: users!.count))
        addFriend.register(UINib(nibName: "AddFriendViewCell", bundle: nil), forCellReuseIdentifier: "AddFriend")
        
        addNavigationMenu()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func addFriend(_ sender: UIButton){
        let touchpoint: CGPoint = sender.convert(CGPoint.zero, to: self.addFriend)
        let buttonIndexPath: NSIndexPath = self.addFriend.indexPathForRow(at: touchpoint)! as NSIndexPath
        let idx=buttonIndexPath.row
        print(idx)
        if(user?.friends?.contains((users?[idx])!))!{
            let alertView = UIAlertController(title: "Easy There",
                                              message: "This Person is already your friend" as String, preferredStyle:.alert)
            let okAction = UIAlertAction(title: "add another friend", style: .default, handler: nil)
            alertView.addAction(okAction)
            self.present(alertView, animated: true, completion: nil)
        }
        else if((user?.email)! == (users?[idx])?.email){
            let alertView = UIAlertController(title: "Easy There",
                                              message: "You Cant Add Yourself" as String, preferredStyle:.alert)
            let okAction = UIAlertAction(title: "add another friend", style: .default, handler: nil)
            alertView.addAction(okAction)
            self.present(alertView, animated: true, completion: nil)
        }
        else{
            print("reach the click")
           user?.friends?.append((users?[idx])!)
            
            let newNum=(user?.friendid)!+","+String(users![idx].id)
                        let val = uomeDB.instance.updateUsersFriends(cid: user!.id, newNum: newNum)
          print(val)
        }
    }
    
    
    // MARK: Favor tableview
    func tableView(_ tableView:UITableView, numberOfRowsInSection section:Int) -> Int
    {
        users=uomeDB.instance.getUsers()
        return users!.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = addFriend.dequeueReusableCell(withIdentifier: "AddFriend", for: indexPath) as! AddFriendViewCell
            
        users=uomeDB.instance.getUsers()
        cell.userName.text=users?[indexPath.row].getFullName()
        cell.addButton.addTarget(self, action: #selector(AddFriend_ViewController.addFriend(_:)), for: .touchUpInside)        //cell.clipsToBounds = true;
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 88
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    
    
    
    
    @IBAction func navClick(_ sender: Any) {
        if (self.wholeView.frame.origin.x == 0){
            showNavigationMenu()
        }
        else{
            hideNavigationMenu()
        }
    }
    // MARK: Navigation Menu
    
    func addNavigationMenu() {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "NavigationMenuViewController")
        (controller as! NavigationMenu_ViewController).user=user
        self.view.insertSubview(controller.view, at: 0)
        
        addChildViewController(controller)
        print(user!.getFullName())
        
        controller.didMove(toParentViewController: self)
        
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(self.respondToSwipeGesture))
        swipeRight.direction = UISwipeGestureRecognizerDirection.right
        self.view.addGestureRecognizer(swipeRight)
        
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(self.respondToSwipeGesture))
        swipeLeft.direction = UISwipeGestureRecognizerDirection.left
        self.view.addGestureRecognizer(swipeLeft)
    }
    
    func showNavigationMenu() {
        UIView.animate(withDuration: 0.35, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0, options: UIViewAnimationOptions(), animations: { self.wholeView.frame.origin.x = 250}, completion: nil)
        
    }
    
    func hideNavigationMenu() {
        UIView.animate(withDuration: 0.25, animations: {
            self.wholeView.frame.origin.x = 0
            
        })
    }
    
    func respondToSwipeGesture(gesture: UIGestureRecognizer) {
        
        if let swipeGesture = gesture as? UISwipeGestureRecognizer {
            switch swipeGesture.direction {
            case UISwipeGestureRecognizerDirection.right:
                if (self.wholeView.frame.origin.x == 0){
                    showNavigationMenu()
                }
            case UISwipeGestureRecognizerDirection.left:
                if (self.wholeView.frame.origin.x != 0){
                    hideNavigationMenu()
                }
                
            default:
                break
            }
        }
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
