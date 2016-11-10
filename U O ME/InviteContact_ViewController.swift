//
//  InviteContact_ViewController.swift
//  U O ME
//
//  Created by Collin Walther on 11/8/16.
//  Copyright © 2016 Collin Walther, Rohit Saigal. All rights reserved.
//

import UIKit
import Contacts

class InviteContact_ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, NavigationMenu_ViewControllerDelegate {

    @IBOutlet var wholeView: UIView!
    @IBOutlet weak var contactTableView: UITableView!
    
    var contactsData = [CNContact]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.

        self.getContacts()
        addNavigationMenu()
    }
    


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    
    
    // Used https://code.tutsplus.com/tutorials/ios-9-an-introduction-to-the-contacts-framework--cms-25599
    func getContacts() {
        let store = CNContactStore()
        
        if CNContactStore.authorizationStatusForEntityType(.Contacts) == .NotDetermined {
            store.requestAccessForEntityType(.Contacts, completionHandler: { (authorized: Bool, error: NSError?) -> Void in
                if authorized {
                    self.retrieveContactsWithStore(store)
                }
            })
        } else if CNContactStore.authorizationStatusForEntityType(.Contacts) == .Authorized {
            self.retrieveContactsWithStore(store)
        }
    }
    
    
    // Used https://code.tutsplus.com/tutorials/ios-9-an-introduction-to-the-contacts-framework--cms-25599
    func retrieveContactsWithStore(store: CNContactStore) {
        do {
            
            let request = CNContactFetchRequest(keysToFetch: [CNContactIdentifierKey, CNContactFormatter.descriptorForRequiredKeysForStyle(.FullName), CNContactPhoneNumbersKey, CNContactImageDataKey])
            
            do {
                try store.enumerateContactsWithFetchRequest(request) { contact, stop in
                    self.contactsData.append(contact)
                }
            } catch {
                print(error)
            }
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                self.contactTableView.reloadData()
            })
        } catch {
            print(error)
        }
    }
    
    
    
    
    
    
    // MARK: - Table view data source
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("NUMROWS: ", self.contactsData
            .count)
        return self.contactsData.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        contactTableView.registerNib(UINib(nibName: "Contact_TableViewCell", bundle: nil), forCellReuseIdentifier: "ContactCell")
        
        
        var cell = contactTableView.dequeueReusableCellWithIdentifier("ContactCell", forIndexPath: indexPath) as! Contact_TableViewCell
        let contact = self.contactsData[indexPath.row]
        let formatter = CNContactFormatter()
        formatter.style = .FullName
        
        cell.nameLabel.text = formatter.stringFromContact(contact)
        
        if (contact.isKeyAvailable(CNContactPhoneNumbersKey)) {
            //for phoneNumber:CNLabeledValue in contact.phoneNumbers {
            let phoneNumber:CNLabeledValue = contact.phoneNumbers[0]
                let a = phoneNumber.value as! CNPhoneNumber
                cell.phoneLabel.text = a.stringValue
            //}
        }
        
        if (contact.imageData != nil){
            
            cell.contactImageView.image = UIImage(data: contact.imageData!)!
        }
        
        return cell
    }
    
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let contact = self.contactsData[indexPath.row]
        
        let phoneNumber:CNLabeledValue = contact.phoneNumbers[0]
        let a = phoneNumber.value as! CNPhoneNumber
        let number = a.stringValue
        sendTextMessage(number)
        
    }
    

    
    
    
    // This code is taken from the link below.
    // Why reinvent the wheel?
    // https://www.andrewcbancroft.com/2014/10/28/send-text-message-in-app-using-mfmessagecomposeviewcontroller-with-swift/
    func sendTextMessage
        (num: String) {
        // Create a MessageComposer
        let messageComposer = MessageComposer(number: num)
        
        
        // Make sure the device can send text messages
        if (messageComposer.canSendText()) {
            // Obtain a configured MFMessageComposeViewController
            let messageComposeVC = messageComposer.configuredMessageComposeViewController()
            
            // Present the configured MFMessageComposeViewController instance
            // Note that the dismissal of the VC will be handled by the messageComposer instance,
            // since it implements the appropriate delegate call-back
            presentViewController(messageComposeVC, animated: true, completion: nil)
        } else {
            // Let the user know if his/her device isn't able to send text messages
            let errorAlert = UIAlertView(title: "Cannot Send Text Message", message: "Your device is not able to send text messages.", delegate: self, cancelButtonTitle: "OK")
            errorAlert.show()
        }
    }
    
    
    
    // MARK: Navigation Menu
    
    @IBAction func navigationClick(sender: AnyObject) {
        
        if (self.wholeView.frame.origin.x == 0){
            showNavigationMenu()
        }
        else{
            hideNavigationMenu()
        }
    }
    
    
    func addNavigationMenu() {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewControllerWithIdentifier("NavigationMenuViewController")
        self.view.insertSubview(controller.view, atIndex: 0)
        
        addChildViewController(controller)
        controller.didMoveToParentViewController(self)
        
    }
    
    func showNavigationMenu() {
        UIView.animateWithDuration(0.35, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0, options: UIViewAnimationOptions.TransitionNone, animations: { self.wholeView.frame.origin.x = 250}, completion: nil)
        
    }
    
    func hideNavigationMenu() {
        UIView.animateWithDuration(0.25, animations: {
            self.wholeView.frame.origin.x = 0
            
        })
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
