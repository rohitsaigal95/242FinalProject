//
//  FavorFeed_ViewController.swift
//  U O ME
//
//  Created by Collin Walther on 11/2/16.
//  Copyright © 2016 Collin Walther, Rohit Saigal. All rights reserved.
//

import UIKit

class FavorFeed_ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var favorTable: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        favorTable.registerNib(UINib(nibName: "Favor_TableViewCell", bundle: nil), forCellReuseIdentifier: "FavorCell")
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    
    // MARK: Favor tableview
    func tableView(tableView:UITableView, numberOfRowsInSection section:Int) -> Int
    {
        return 2
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        let cell = favorTable.dequeueReusableCellWithIdentifier("FavorCell", forIndexPath: indexPath) as! Favor_TableViewCell
        
        cell.topLabel.text = "collin earned 3 points from rohit for:"
        cell.favorTitleLabel.text = "Doing homework"
        
        
        
        return cell
    }
    
    func tableView(tableView: UITableView, estimatedHeightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 108
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
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
