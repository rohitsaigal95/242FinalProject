//
//  SignUp_ViewController.swift
//  U O ME
//
//  Created by Collin Walther on 11/2/16.
//  Copyright © 2016 Collin Walther, Rohit Saigal. All rights reserved.
//

import UIKit

class SignUp_ViewController: UIViewController {
    
    @IBOutlet weak var firstName: UITextField!
    @IBOutlet weak var lastName: UITextField!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    @IBAction func signUpButtonClick(sender: AnyObject) {
        var firstNameFilled : Bool = true
        var lastNameFilled : Bool = true
        var emailFilled : Bool = true
        var passwordFilled : Bool = true
        
        
        if (firstName.text == ""){
            firstNameFilled = false
        }
        if (lastName.text == ""){
            lastNameFilled = false
        }
        if (email.text == ""){
            emailFilled = false
        }
        if (password.text == ""){
            passwordFilled = false
        }
        
        if (firstNameFilled && lastNameFilled && emailFilled && passwordFilled){
            
        }
        else{
            changeTextFieldHintColors(firstNameFilled, lastNameFlag: lastNameFilled, emailFlag: emailFilled, passwordFlag: passwordFilled)
            let errorAlert = UIAlertView(title: "Missing information", message: "Please fill in all of the fields", delegate: self, cancelButtonTitle: "OK")
            errorAlert.show()
        }
        
    }
    
    
    func changeTextFieldHintColors(firstNameFlag : Bool, lastNameFlag: Bool, emailFlag: Bool, passwordFlag: Bool){
        
        var pcolor : UIColor = UIColor.grayColor()
        
        if (firstNameFlag == false){
            pcolor = UIColor.redColor()
        }
        firstName.attributedPlaceholder = NSAttributedString(string:"First Name",
                                                                 attributes:[NSForegroundColorAttributeName: pcolor])
        pcolor = UIColor.grayColor()
        if (lastNameFlag == false){
            pcolor = UIColor.redColor()
        }
        lastName.attributedPlaceholder = NSAttributedString(string:"Last Name",
                                                             attributes:[NSForegroundColorAttributeName: pcolor])
        
        pcolor = UIColor.grayColor()
        if (emailFlag == false){
            pcolor = UIColor.redColor()
        }
        email.attributedPlaceholder = NSAttributedString(string:"Email",
                                                             attributes:[NSForegroundColorAttributeName: pcolor])
        
        pcolor = UIColor.grayColor()
        if (passwordFlag == false){
            pcolor = UIColor.redColor()
        }
        password.attributedPlaceholder = NSAttributedString(string:"Password",
                                                             attributes:[NSForegroundColorAttributeName: pcolor])
    }
}
