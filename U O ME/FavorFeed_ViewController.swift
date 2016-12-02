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
    var idx:Int?
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
            //value.pendingFavors=User.updateFavorStatus(arr: user.pendingFavors)
            value.updatePendingFavors()
            let arr=User.getFavorsThatAre(status: "incomplete", arr: value.pendingFavors)
            
            return arr!.count
        }
        return 1
    }
    @IBAction func acceptTask(_ sender: UIButton) {
        
        
        let touchpoint: CGPoint = sender.convert(CGPoint.zero, to: self.favorTable)
        let buttonIndexPath: NSIndexPath = self.favorTable.indexPathForRow(at: touchpoint)! as NSIndexPath
        let x=buttonIndexPath.row
        user.updatePendingFavors()
        idx=Int((User.getFavorsThatAre(status: "incomplete", arr: user.pendingFavors)?[x].favorid)!)
        print(idx!)

        performSegue(withIdentifier: "FavorToAccept", sender: self)
        
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        if let value=user{
            let cell = favorTable.dequeueReusableCell(withIdentifier: "FavorCell", for: indexPath as IndexPath) as! Favor_TableViewCell
            //value.getPendingAndRequestedFavors()
            //value.pendingFavors=User.updateFavorStatus(arr: user.pendingFavors)
            value.updatePendingFavors()
            let arr=User.getFavorsThatAre(status: "incomplete", arr: value.pendingFavors)
            let currFavor=arr?[indexPath.row]
            print(currFavor?.status)
            let firstPart=(currFavor?.getSenderName())! + " offers: " + String(describing: currFavor!.value)
            cell.topLabel.text = firstPart + " points"
            
            cell.favorTitleLabel.text = currFavor?.favorDescription as! String
            cell.acceptButton.addTarget(self, action: #selector(FavorFeed_ViewController.acceptTask(_:)), for: .touchUpInside)
            cell.clipsToBounds=true
            return cell
            
        }
        else{
            let cell = favorTable.dequeueReusableCell(withIdentifier: "FavorCell", for: indexPath as IndexPath) as! Favor_TableViewCell
            
            cell.topLabel.text = "collin earned 3 points from rohit for:"
            cell.favorTitleLabel.text = "Doing homework"
            
            //cell.clipsToBounds = true;
            
            return cell
        }
    }
    
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 110
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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if(segue.identifier == "FavorToAccept"){
            print("profile to accept segue passed data")
                        let userProfile = (segue.destination as! Accept_ViewController)
                        userProfile.user = user
                        userProfile.idx=idx
            
            
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
