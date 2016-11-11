//
//  Badges_ViewController.swift
//  U O ME
//
//  Created by Collin Walther on 11/10/16.
//  Copyright © 2016 Collin Walther, Rohit Saigal. All rights reserved.
//

import UIKit

class Badges_ViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, NavigationMenu_ViewControllerDelegate{

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
        return 2
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if (section == 1){
            return 2
        }
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Badge Cell",
                                                      for: indexPath) as! Badge_CollectionViewCell
        
        let index :Int = (indexPath.section * 3) + indexPath.item
        
        if (index < badgeList.count){
            cell.configureCell(badge: badgeList[index])
        }
        
        return cell
        
    }
    
    
    // MARK: - Collection View delegate
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        print("selected cell")
        
        
        let backdrop: UIView = UIView(frame: CGRect(x: 0, y: 0, width: wholeView.frame.width, height: wholeView.frame.height))
        backdrop.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        backdrop.isUserInteractionEnabled = true
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.exitBadgeFocus(gestureRecognizer:)))
        backdrop.addGestureRecognizer(tapRecognizer)
        
        let backgroundView: UIView = UIView(frame: CGRect(x: 40, y: 80, width: 200, height: 200))
        backgroundView.backgroundColor = UIColor.cyan
        
        let index: Int = (indexPath.section * 3) + indexPath.item
        let badge: Badge = badgeList[index]

        
        let titleLabel: UILabel = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 20))
        titleLabel.text = badge.badgeLabelText
        
        let descriptionLabel: UILabel = UILabel(frame: CGRect(x: 0, y: 40, width: 200, height: 20))
        descriptionLabel.text = badge.badgeDescription
        
        
        backgroundView.addSubview(titleLabel)
        backgroundView.addSubview(descriptionLabel)
        backdrop.addSubview(backgroundView)
        
        wholeView.addSubview(backdrop)
        
    }

    
    func exitBadgeFocus(gestureRecognizer: UITapGestureRecognizer) {
        let backdrop = gestureRecognizer.view!
        backdrop.removeFromSuperview()
    }
    
    
    
    
    
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
