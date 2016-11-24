//
//  RequestFavor.swift
//  U O ME
//
//  Created by Rohit Saigal on 11/3/16.
//  Copyright © 2016 Collin Walther, Rohit Saigal. All rights reserved.
//

import UIKit


class RequestFavor: UIViewController{
    

    @IBOutlet weak var recipientName: UITextField!
    
    @IBOutlet weak var favorValue: UISlider!

    @IBOutlet weak var displayFavor: UITextView!
    var user:User!
    var friend:User?
    var friends:[User]!
    var value:User!
    var newsFeed:[Favor]?
    override func viewDidLoad() {
        
        super.viewDidLoad()
       
      
        user=value
      
        //friend=(presentingViewController as! UserProfile).friend
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func changeSlider(_ sender: Any) {
        displaySlider.text=String(Int(favorValue.value))
        
    }
    
    @IBOutlet weak var displaySlider: UILabel!
    @IBAction func request(_ sender: Any) {
        //Pass.passed.added=true
        //if let isadded=Pass.passed.added{
        //    print(isadded)
        //}
    print("button was pressed")
        var valid=false
        
        var recipient:User?
        
        print(friends.count)
            for u in friends!{
                print(u.first)
                switch(u.first.caseInsensitiveCompare(recipientName.text!))
                    
                {
                case .orderedSame:
                    recipient=u
                    valid=true
                    break
                default:
                    break
                }
            }
        
        if(valid==false){
            displayFavor.text="Please enter a valid friend name!"
            recipientName.text="Enter Valid Name"
            favorValue.value=0
            displaySlider.text=""
            return
//            recipient=User(name: recipientName.text!, level: 0, image: UIImage(named: "default-profile.png")!, points: 0)
        }
        
        
        let newFavor=Favor(sender:user,value: Int(favorValue.value), recipient: recipient!, favorDescription: displayFavor.text as NSString)
        recipient?.favorHistory.append(newFavor)
        recipient?.pendingFavors.append(newFavor)
        user.requestedFavors.append(newFavor)
        user?.favorHistory.append(newFavor)
        newsFeed?.insert(newFavor, at: 0)
        
        performSegue(withIdentifier: "RequestToProfile", sender: self)
//        let storyboard = UIStoryboard(name: "Main", bundle: nil)
//        let controller = storyboard.instantiateViewController(withIdentifier: "News Feed")
//        self.present(controller, animated: true, completion: nil)
        
        /*
        let controller = self.storyboard!.instantiateViewControllerWithIdentifier("User Profile")
        self.presentViewController(controller,animated:true,completion:nil)
    */
    }
    
//    @IBAction func sliderAction(sender: AnyObject) {
//        
//        displaySlider.text=String(Int(favorValue.value))
//    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "RequestToProfile"){
            print("favor to prifle")
            let userProfile = (segue.destination as! UserProfile)
            userProfile.user = user
            userProfile.friends=friends
            userProfile.newsFeed=newsFeed
            
        }
    }




}
