//
//  Favor_TableViewCell.swift
//  U O ME
//
//  Created by Collin Walther on 11/2/16.
//  Copyright © 2016 Collin Walther, Rohit Saigal. All rights reserved.
//

import UIKit

class Favor_TableViewCell: UITableViewCell {

    @IBOutlet weak var topLabel: UILabel!
    @IBOutlet weak var favorTitleLabel: UILabel!
   
    @IBOutlet weak var acceptButton: UIButton!
    var recipient:User?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

//    @IBAction func acceptTask(_ sender: UIButton) {
//        /// implement accept a task
//        print("clickkkk")
//       
//            
////            recipient?.pendingFavors.remove(at: sender.tag)
//            // Your code here
//        
//    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
       
        // Configure the view for the selected state
    }
    
}
