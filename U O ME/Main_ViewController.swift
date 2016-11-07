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
    let createLoginButtonTag = 0
    let loginButtonTag = 1
    @IBOutlet weak var loginButton: UIButton!
    
    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet var swipeRecognizer: UISwipeGestureRecognizer!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // 1.
        let hasLogin = NSUserDefaults.standardUserDefaults().boolForKey("hasLoginKey")
        
        // 2.
        if hasLogin {
            loginButton.setTitle("Login", forState: UIControlState.Normal)
            loginButton.tag = loginButtonTag
            //createInfoLabel.hidden = true
        } else {
            loginButton.setTitle("Create", forState: UIControlState.Normal)
            loginButton.tag = createLoginButtonTag
            //createInfoLabel.hidden = false
        }
        
        // 3.
        if let storedUsername = NSUserDefaults.standardUserDefaults().valueForKey("username") as? String {
            usernameField.text = storedUsername as String
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    

    func handleSwipe(sender:UISwipeGestureRecognizer){
        if (sender.direction == .Left){
            print("dsfds")
        }
    }

    
    
    
    @IBAction func loginAction(sender: AnyObject) {
        
        // 1.
        if (usernameField.text == "" || passwordField.text == "") {
            let alertView = UIAlertController(title: "Login Problem",
                                              message: "Wrong username or password." as String, preferredStyle:.Alert)
            let okAction = UIAlertAction(title: "Foiled Again!", style: .Default, handler: nil)
            alertView.addAction(okAction)
            self.presentViewController(alertView, animated: true, completion: nil)
            return;
        }
        
        // 2.
        usernameField.resignFirstResponder()
        passwordField.resignFirstResponder()
        
        // 3.
        if sender.tag == createLoginButtonTag {
            
            // 4.
            let hasLoginKey = NSUserDefaults.standardUserDefaults().boolForKey("hasLoginKey")
            if hasLoginKey == false {
                NSUserDefaults.standardUserDefaults().setValue(self.usernameField.text, forKey: "username")
            }
            
            // 5.
            MyKeychainWrapper.mySetObject(passwordField.text, forKey:kSecValueData)
            MyKeychainWrapper.writeToKeychain()
            NSUserDefaults.standardUserDefaults().setBool(true, forKey: "hasLoginKey")
            NSUserDefaults.standardUserDefaults().synchronize()
            loginButton.tag = loginButtonTag
            
            performSegueWithIdentifier("newsFeed", sender: self)
        } else if sender.tag == loginButtonTag {
            // 6.
            if checkLogin(usernameField.text!, password: passwordField.text!) {
                performSegueWithIdentifier("newsFeed", sender: self)
            } else {
                // 7.
                let alertView = UIAlertController(title: "Login Problem",
                                                  message: "Wrong username or password." as String, preferredStyle:.Alert)
                let okAction = UIAlertAction(title: "Foiled Again!", style: .Default, handler: nil)
                alertView.addAction(okAction)
                self.presentViewController(alertView, animated: true, completion: nil)
            }
        }
        
    }
    
    
    func checkLogin(username: String, password: String ) -> Bool {
        if password == MyKeychainWrapper.myObjectForKey("v_Data") as? String &&
            username == NSUserDefaults.standardUserDefaults().valueForKey("username") as? String {
            return true
        } else {
            return false
        }
    }
    
    

}

