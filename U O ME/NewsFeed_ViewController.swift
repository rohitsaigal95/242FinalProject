//
//  NewsFeed_ViewController.swift
//  U O ME
//
//  Created by Collin Walther on 11/2/16.
//  Copyright © 2016 Collin Walther, Rohit Saigal. All rights reserved.
//

import UIKit


class NewsFeed_ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{

    @IBOutlet weak var newsTable: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        newsTable.registerNib(UINib(nibName: "News_TableViewCell", bundle: nil), forCellReuseIdentifier: "NewsCell")

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
        let cell = newsTable.dequeueReusableCellWithIdentifier("NewsCell", forIndexPath: indexPath) as! News_TableViewCell
        
        if indexPath.row == 0{
            cell.topLabel.text = "Collin W. earned 3 points from Rohit S. for:"
            cell.favorTitleLabel.text = "Doing homework"
        }
        else{
            cell.topLabel.text = "Rohit S. awarded 6 points to Benjamin D. for:"
            cell.favorTitleLabel.text = "Picking up the pizza"
        }
        
        
        
        return cell
    }
    
    func tableView(tableView: UITableView, estimatedHeightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 88
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
