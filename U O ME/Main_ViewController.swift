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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
        if let storedUsername = NSUserDefaults.standardUserDefaults().valueForKey("email") as? String {
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
        
        if (usernameField.text == "" || passwordField.text == "") {
            let alertView = UIAlertController(title: "Login Problem",
                                              message: "Wrong username or password." as String, preferredStyle:.Alert)
            let okAction = UIAlertAction(title: "Try again", style: .Default, handler: nil)
            alertView.addAction(okAction)
            self.presentViewController(alertView, animated: true, completion: nil)
            return;
        }
        
        usernameField.resignFirstResponder()
        passwordField.resignFirstResponder()
        
        
            if checkLogin(usernameField.text!, password: passwordField.text!) {
                performSegueWithIdentifier("newsFeed", sender: self)
            } else {
                // 7.
                let alertView = UIAlertController(title: "Login Problem",
                                                  message: "Wrong username or password." as String, preferredStyle:.Alert)
                let okAction = UIAlertAction(title: "Try again", style: .Default, handler: nil)
                alertView.addAction(okAction)
                self.presentViewController(alertView, animated: true, completion: nil)
            }
        
        
    }
    
    
    func checkLogin(username: String, password: String ) -> Bool {

        if password == MyKeychainWrapper.myObjectForKey("v_Data") as! String &&
            username == NSUserDefaults.standardUserDefaults().valueForKey("email") as? String {
            print("Success login!")
            return true
        } else {
            return false
        }
    }
    
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        
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
    
    

}

