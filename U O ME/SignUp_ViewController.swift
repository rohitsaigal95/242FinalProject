//
//  SignUp_ViewController.swift
//  U O ME
//
//  Created by Collin Walther on 11/2/16.
//  Copyright © 2016 Collin Walther, Rohit Saigal. All rights reserved.
//

import UIKit

class SignUp_ViewController: UIViewController {
    
    let MyKeychainWrapper = KeychainWrapper()
    
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
    
    
    
    @IBAction func signUpButtonClick(_ sender: AnyObject) {
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
            UserDefaults.standard.setValue(firstName.text, forKey: "firstName")
            UserDefaults.standard.setValue(lastName.text, forKey: "lastName")
            UserDefaults.standard.setValue(email.text, forKey: "email")

            
            print(password.text)
            MyKeychainWrapper.mySetObject(password.text!, forKey:"v_Data")
            MyKeychainWrapper.writeToKeychain()
            UserDefaults.standard.set(true, forKey: "hasLoginKey")
            UserDefaults.standard.synchronize()
            
            performSegue(withIdentifier: "SignUpToNews", sender: self)
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let controller = storyboard.instantiateViewController(withIdentifier: "News Feed")
            self.present(controller, animated: true, completion: nil)
        }
        else{
            changeTextFieldHintColors(firstNameFilled, lastNameFlag: lastNameFilled, emailFlag: emailFilled, passwordFlag: passwordFilled)
            let errorAlert = UIAlertView(title: "Missing information", message: "Please fill in all of the fields", delegate: self, cancelButtonTitle: "OK")
            errorAlert.show()
        }
        
    }
    
    
    func changeTextFieldHintColors(_ firstNameFlag : Bool, lastNameFlag: Bool, emailFlag: Bool, passwordFlag: Bool){
        
        var pcolor : UIColor = UIColor.gray
        
        if (firstNameFlag == false){
            pcolor = UIColor.red
        }
        firstName.attributedPlaceholder = NSAttributedString(string:"First Name",
                                                                 attributes:[NSForegroundColorAttributeName: pcolor])
        pcolor = UIColor.gray
        if (lastNameFlag == false){
            pcolor = UIColor.red
        }
        lastName.attributedPlaceholder = NSAttributedString(string:"Last Name",
                                                             attributes:[NSForegroundColorAttributeName: pcolor])
        
        pcolor = UIColor.gray
        if (emailFlag == false){
            pcolor = UIColor.red
        }
        email.attributedPlaceholder = NSAttributedString(string:"Email",
                                                             attributes:[NSForegroundColorAttributeName: pcolor])
        
        pcolor = UIColor.gray
        if (passwordFlag == false){
            pcolor = UIColor.red
        }
        password.attributedPlaceholder = NSAttributedString(string:"Password",
                                                             attributes:[NSForegroundColorAttributeName: pcolor])
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "SignUpToNews"){
            print("segue reached")
            let owner:User=User(name: (firstName.text! + "," + lastName.text!), level: 0, image:UIImage(named:"profile_icon  30x30.png")!, points:0, email: email.text!)
            var friends=[User(name: "Collin", level: 0, image:UIImage(named:"profile_icon  30x30.png")!, points:0,email:"cwalthe2@illinois.edu"),User(name: "Nitish", level: 0, image:UIImage(named:"profile_icon  30x30.png")!, points:0,email:"nitishistheman@studmuffin.edu"),User(name: "Jayme", level: 0, image:UIImage(named:"profile_icon  30x30.png")!, points:0,email:"jayms_parker@bentley.edu")]
            let newsFeed = (segue.destination as! NewsFeed_ViewController)
            
            newsFeed.user=owner
            newsFeed.friends=friends
            let toAccept=Favor(sender: friends[0], value: 3, recipient: owner, favorDescription: "Give me a ride from grainger?")
            let toAccept2=Favor(sender: friends[1], value: 10, recipient: owner, favorDescription: "Give me An A+++++ :) m?")
            owner.pendingFavors.append(toAccept)
            owner.pendingFavors.append(toAccept2)
            
            let news = [Favor(sender: friends[0], value: 0, recipient: owner, favorDescription: "This is a newsfeed favor")]
            newsFeed.newsFeed=news
        }
       
    }
}
