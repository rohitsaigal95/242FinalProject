//
//  ViewController.swift
//  U O ME
//
//  Created by Collin Walther on 11/1/16.
//  Copyright © 2016 Collin Walther, Rohit Saigal. All rights reserved.
//

import UIKit

class Main_ViewController: UIViewController {
    
    let MyKeychainWrapper = KeychainWrapper()

    @IBOutlet weak var loginButton: UIButton!
    
    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet var swipeRecognizer: UISwipeGestureRecognizer!
    var owner:User?
    var friends:[User]?
    var news:[Favor]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        var assigned=false
        friends=[User(name: "Collin", level: 0, image:UIImage(named:"profile_icon  30x30.png")!, points:0,email:"cwalthe2@illinois.edu"),User(name: "Nitish", level: 0, image:UIImage(named:"profile_icon  30x30.png")!, points:0,email:"nitishistheman@studmuffin.edu"),User(name: "Jayme", level: 0, image:UIImage(named:"profile_icon  30x30.png")!, points:0,email:"jayms_parker@bentley.edu"),User(name: "Rohit", level: 0, image:UIImage(named:"profile_icon  30x30.png")!, points:0,email:"rohitnsaigal@gmail.com")]
        
        if let storedUsername = UserDefaults.standard.value(forKey: "email") as? String {
            usernameField.text = storedUsername as String
            for u in friends!{
                print(u.name)
                switch(u.email.caseInsensitiveCompare(storedUsername))
                    
                {
                case .orderedSame:
                    owner=u
                    assigned=true
                    break
                default:
                    break
                }
            }
            
        }
        if(assigned==true){print("true")
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    

    func handleSwipe(_ sender:UISwipeGestureRecognizer){
        if (sender.direction == .left){
            print("swiped left")
        }
    }

    
    
    
    @IBAction func loginAction(_ sender: AnyObject) {
        
        if (usernameField.text == "" || passwordField.text == "") {
            let alertView = UIAlertController(title: "Login Problem",
                                              message: "Wrong username or password." as String, preferredStyle:.alert)
            let okAction = UIAlertAction(title: "Try again", style: .default, handler: nil)
            alertView.addAction(okAction)
            self.present(alertView, animated: true, completion: nil)
            return;
        }
        
        usernameField.resignFirstResponder()
        passwordField.resignFirstResponder()
        
        
            if checkLogin(usernameField.text!, password: passwordField.text!) {
                performSegue(withIdentifier: "newsFeed", sender: self)
            } else {
                // 7.
                let alertView = UIAlertController(title: "Login Problem",
                                                  message: "Wrong username or password." as String, preferredStyle:.alert)
                let okAction = UIAlertAction(title: "Try again", style: .default, handler: nil)
                alertView.addAction(okAction)
                self.present(alertView, animated: true, completion: nil)
            }
        
        
    }
    
    
    func checkLogin(_ username: String, password: String ) -> Bool {

        if password == MyKeychainWrapper.myObject(forKey: "v_Data") as! String &&
            username == UserDefaults.standard.value(forKey: "email") as? String {
            print("Success login!")
            return true
        } else {
            return false
        }
    }
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        if (textField == usernameField){
            usernameField.endEditing(true)
            passwordField.becomeFirstResponder()
        }
        else{
            passwordField.endEditing(true)
            loginAction(loginButton)
        }
        

        return false
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier=="newsFeed"){
            print("called")
            let newsFeed=segue.destination as! NewsFeed_ViewController
            let toAccept=Favor(sender: (friends?[0])!, value: 3, recipient: owner!, favorDescription: "Give me a ride from grainger?")
            let toAccept2=Favor(sender: (friends?[1])!, value: 10, recipient: owner!, favorDescription: "Give me An A+++++ :) m?")
            owner?.pendingFavors.append(toAccept)
            owner?.pendingFavors.append(toAccept2)
            
             
            newsFeed.user=owner
            newsFeed.friends=friends
            let news = [Favor(sender: (friends?[0])!, value: 0, recipient: owner!, favorDescription: "This is a newsfeed favor")]
            newsFeed.newsFeed=news
            
        }
        
//        if(segue.identifier == "LoginToFavor"){
//            var user:User=User(name: String, level: <#T##NSInteger#>, image: <#T##UIImage#>, points: <#T##NSInteger#>)
//            let requestFavor = (segue.destination as! RequestFavor)
//            requestFavor.value = user
//            requestFavor.friends=friends
//        }
        
    }

}

