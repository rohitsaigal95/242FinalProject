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
    @IBOutlet var wholeView: UIView!
    var user:User?
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        newsTable.register(UINib(nibName: "News_TableViewCell", bundle: nil), forCellReuseIdentifier: "NewsCell")

        addNavigationMenu()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    
    // MARK: Favor tableview
    func tableView(_ tableView:UITableView, numberOfRowsInSection section:Int) -> Int
    {
        return (user?.getNewsFeed()?.count)!
    }
    /*
 news feed table showing all favors 
 */
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = newsTable.dequeueReusableCell(withIdentifier: "NewsCell", for: indexPath) as! News_TableViewCell
        let currFavor=user?.getNewsFeed()?[indexPath.row]
//        cell.topLabel.text=currFavor?.getSenderName() +"requested " + String(currFavor?.value) + " points from " + currFavor?.getRecipientName()
        let first = (currFavor?.getSenderName())! + " requested "
        cell.topLabel.text=first + String(describing: currFavor!.value) + " points from " + (currFavor?.getRecipientName())!
        cell.favorTitleLabel.text=currFavor?.favorDescription as! String
//        if indexPath.row == 0{
//            cell.topLabel.text = "Collin W. earned 3 points from Rohit S. for:"
//            cell.favorTitleLabel.text = "Doing homework"
//        }
//        else{
//            cell.topLabel.text = "Rohit S. awarded 6 points to Benjamin D. for:"
//            cell.favorTitleLabel.text = "Picking up the pizza"
//        }
//        
        
        //cell.clipsToBounds = true;
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 88
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
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
