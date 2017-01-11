//
//  TSScrapTreeViewController.swift
//  TravelShare
//
//  Created by jeongkyu kim on 2017. 2. 14..
//  Copyright © 2017년 jungk. All rights reserved.
//

import UIKit

class TSScrapTreeViewController : UIViewController, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    @IBOutlet var collectionView:UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.scrapChanged), name:.TSScrapNavigationChanged, object: nil)
    }
    
    deinit {
        
        NotificationCenter.default.removeObserver(self)
    }
    
    func scrapChanged(notification:NSNotification) {
        
        self.collectionView.reloadData()
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        
        return TSScrapNavigator.sharedInstance.numberOfSection
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return TSScrapNavigator.sharedInstance.numberOfItemIn(section: section)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TSScrapNaviCell", for: indexPath)
        
        if let taskCell = cell as? TSScrapNaviCell {
            
            if let taskInfo = TSScrapNavigator.sharedInstance.taskInfoAt(indexPath: indexPath) {
                
                taskCell.taskInfo = taskInfo
                
                if TSScrapNavigator.sharedInstance.selectedScrap(scrapInfo:taskInfo.scrap) == true {
                    
                    collectionView.selectItem(at: indexPath, animated: false, scrollPosition: .centeredVertically)
                } else {
                    collectionView.deselectItem(at: indexPath, animated: false)
                }
            }
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TSScrapNaviCell", for: indexPath)
        
        if cell.isSelected == true {
            collectionView.deselectItem(at: indexPath, animated: false)
            TSScrapNavigator.sharedInstance.deselectedScrapAt(indexPath:indexPath)
            return false
        }
        return true
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        TSScrapNavigator.sharedInstance.selectedScrapAt(indexPath:indexPath)
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        
        TSScrapNavigator.sharedInstance.deselectedScrapAt(indexPath:indexPath)
    }
 
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: self.view.frame.width , height: 50)
    }
    
}
