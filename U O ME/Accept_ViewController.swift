//
//  Accept_ViewController.swift
//  U O ME
//
//  Created by Rohit Saigal on 12/1/16.
//  Copyright © 2016 Collin Walther, Rohit Saigal. All rights reserved.
//

import UIKit

class Accept_ViewController: UIViewController {

    
    
    @IBOutlet weak var favorDescription: UILabel!
    @IBOutlet weak var people: UILabel!
    var user:User?
    var idx:Int?
    var currfavor:Favor?
    override func viewDidLoad() {
        super.viewDidLoad()
//        people.text=(currfavor?.getSenderName())! + "is asking you for " + String(describing: currfavor!.value) + " for:"
        var favors=uomeDB.instance.getFavors()
        for fav in favors{
            if (Int(fav.favorid)==idx){
                currfavor=fav
            }
        }
       // currfavor=favors.contains(where: <#T##(Favor) throws -> Bool#>)
        people.text=(currfavor?.getSenderName())!+" is asking you for \n" + String(describing: currfavor!.value) + " for: "
        favorDescription.text=currfavor!.favorDescription as String
        // Do any additional setup after loading the view.
    }

    @IBAction func acceptFavor(_ sender: Any) {
//        user?.pendingFavors.remove(at: idx!)
        
        print((currfavor?.favorid)!)
        
        print("result of update is")
        print(uomeDB.instance.updateFavorStatus(fid: (currfavor?.favorid)!, newStatus: "complete"))
//        user!.pendingFavors[idx!].status="complete"
        var y = user?.pendingFavors.index(of: currfavor!)
        self.navigationController?.popViewController(animated: true)
        //(self.navigationController?.parent as! FavorFeed_ViewController).user=user
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
