//
//  Badges_ViewController.swift
//  U O ME
//
//  Created by Collin Walther on 11/10/16.
//  Copyright © 2016 Collin Walther, Rohit Saigal. All rights reserved.
//

import UIKit

class Badges_ViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, NavigationMenu_ViewControllerDelegate {

    @IBOutlet weak var wholeView: UIView!
    @IBOutlet weak var badgesCollectionView: UICollectionView!
    //fileprivate let sectionInsets = UIEdgeInsets(top: 50.0, left: 20.0, bottom: 50.0, right: 20.0)
    //fileprivate let itemsPerRow: CGFloat = 3
    let badgeList: Array<Badge> = Badge.getBadgeList()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        badgesCollectionView.register(UINib(nibName: "Badge_CollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "Badge Cell")
     
        addNavigationMenu()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    
    
    // MARK: - Collection View data source
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Badge Cell",
                                                      for: indexPath) as! Badge_CollectionViewCell
        
        cell.configureCell(badge: badgeList[indexPath.row])
        
        return cell
        
    }
    
    
    // MARK: - Collection View delegate
    /*
    
    func collectionView(_ collectionView: UICollectionView,
                           layout collectionViewLayout: UICollectionViewLayout,
                           sizeForItemAt indexPath: IndexPath) -> CGSize {
    
        //let paddingSpace = sectionInsets.left * (itemsPerRow + 1)
        //let availableWidth = view.frame.width - paddingSpace
        //let widthPerItem = availableWidth / itemsPerRow
        
        //return CGSize(width: widthPerItem, height: widthPerItem)
        
        print("sdfds")
        return CGSize(width: 181, height: 181)
    }
    
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        return sectionInsets
    }
    
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return sectionInsets.left
    }

    */
    
    
    
    
    
    // MARK: Navigation Menu
    
    @IBAction func navigationClick(_ sender: AnyObject) {
        
        if (self.wholeView.frame.origin.x == 0){
            showNavigationMenu()
        }
        else{
            hideNavigationMenu()
        }
    }
    
    
    func addNavigationMenu() {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "NavigationMenuViewController")
        self.view.insertSubview(controller.view, at: 0)
        
        addChildViewController(controller)
        controller.didMove(toParentViewController: self)
        
    }
    
    func showNavigationMenu() {
        UIView.animate(withDuration: 0.35, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0, options: UIViewAnimationOptions(), animations: { self.wholeView.frame.origin.x = 250}, completion: nil)
        
    }
    
    func hideNavigationMenu() {
        UIView.animate(withDuration: 0.25, animations: {
            self.wholeView.frame.origin.x = 0
            
        })
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
