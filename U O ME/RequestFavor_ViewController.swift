//
//  RequestFavor.swift
//  U O ME
//
//  Created by Rohit Saigal on 11/3/16.
//  Copyright © 2016 Collin Walther, Rohit Saigal. All rights reserved.
//

import UIKit

/*
 request view controller
 */
class RequestFavor: UIViewController{
    

    @IBOutlet weak var recipientName: UITextField!
    
    
    @IBOutlet weak var favorValue: UISlider!

    @IBOutlet weak var displaySlider: UILabel!
    @IBOutlet weak var displayFavor: UITextView!
    var user:User!
    var friend:User?
    var friends:[User]?
    var value:User!
    override func viewDidLoad() {
        
        super.viewDidLoad()
       //print(user.getFullName())
        
      print("request favor loaded")
        
        //friend=(presentingViewController as! UserProfile).friend
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /*
     request a favor and adds favor to databse
 */
    @IBAction func requestFAvor(_ sender: Any) {
        print("button was pressed")
//        var valid=false
//        
        var recipient:User?
//
        print(user.friends!.count)
        for u in user.friends!{
            print(u.first)
            switch(u.first.caseInsensitiveCompare(recipientName.text!))
                
            {
            case .orderedSame:
                print("oreder same")
                recipient=u
                recipientName.text=u.email
                break
            default:
                break
            }
        }
//
//        //        if(valid==false){
//        //            recipient=User(first: recipientName.text!, level: 0, image: UIImage(named: "default-profile.png")!, points: 0)
//        //        }
//        //
//        
       
        
        if(recipient==nil){
            let alertView = UIAlertController(title: "Sorry :(",
                                              message: "This person isn't in your friends" as String, preferredStyle:.alert)
            let okAction = UIAlertAction(title: "ask a different friend", style: .default, handler: nil)
            alertView.addAction(okAction)
            self.present(alertView, animated: true, completion: nil)
            return
        }
        print(recipient?.getFullName())
        let newFavor=Favor(value: Int(favorValue.value), recipient: recipient!, favorDescription: displayFavor.text as NSString, sender:user,favorid:-1,status:"incomplete")
        recipient?.favorHistory.append(newFavor)
        recipient?.pendingFavors.append(newFavor)
        user.requestedFavors.append(newFavor)
        user?.favorHistory.append(newFavor)
        uomeDB.instance.addFavor(newFavor: newFavor)
        
        /*
         let controller = self.storyboard!.instantiateViewControllerWithIdentifier("User Profile")
         self.presentViewController(controller,animated:true,completion:nil)
         se
         */
        //self.dismiss(animated: true, completion: nil)
        //navigationController?.popViewController(animated: true)
        
        
        self.navigationController?.popViewController(animated: true)
    }

    /*
 cancel button to pop view controller
 */
    @IBAction func cancel(_ sender: Any) {
        
        self.navigationController?.popViewController(animated: true)
    }
    
    /*
     update slider value as user interacts with it
 */
    @IBAction func sliderAction(_ sender: Any) {
        displaySlider.text=String(Int(favorValue.value))
    }
    
 /*
 segue to pass data
 */
    func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if(segue.identifier == "RequestToProfile"){
            print("sup")
            let userProfile = (segue.destination as! UserProfile)
            userProfile.user = user
            
        }
    }




}
