//
//  Accept_ViewController.swift
//  U O ME
//
//  Created by Rohit Saigal on 11/19/16.
//  Copyright © 2016 Collin Walther, Rohit Saigal. All rights reserved.
//

import UIKit

class Accept_ViewController: UIViewController {
    var user:User!
    var friends:[User]?
    var newsFeed:[Favor]?
    var idx:Int?
    var curr:Favor?
    @IBOutlet weak var favorDescription: UILabel!
    @IBOutlet weak var people: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        print(user.first)
        curr=user?.pendingFavors[idx!]
        favorDescription.text=curr?.favorDescription as String?
        
        people.text=(curr?.sender.first)! + " will give you " + (curr?.value.description)!
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func acceptFavor(_ sender: Any) {
        print(String(describing: idx))
        user?.pendingFavors.remove(at: idx!)
        performSegue(withIdentifier: "AcceptToFavor", sender: self)
        
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "AcceptToFavor"){
            print("profile to favor")
            let userProfile = (segue.destination as! FavorFeed_ViewController)
            userProfile.user = user
            userProfile.friends=friends
            userProfile.newsFeed=newsFeed
            
        }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
