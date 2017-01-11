//
//  ViewController.swift
//  TravelShare
//
//  Created by jeongkyu kim on 2017. 1. 10..
//  Copyright © 2017년 jungk. All rights reserved.
//

import UIKit

class TSCreatorViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    @IBOutlet var taskCollectionView : UICollectionView!
    @IBOutlet var addButtonView : UIView!
    
    let scrapImportHelper : TSScrapImportHelper = TSScrapImportHelper()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.addButtonView.onRoundBorder()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func addTaskInfo(_ sender:UIButton) {
    
        let scrap:TSScrapInfo = TSScrapInfo()
        
        scrap.category = TSScrapCategory.random()
        
        self.scrapImportHelper.addScrap(scrap)
        
        let insertIndexPath : IndexPath = IndexPath(item: self.scrapImportHelper.numberOfTask - 1, section: 0)
        
        self.taskCollectionView.performBatchUpdates({
            
            self.taskCollectionView.insertItems(at: [insertIndexPath])
            
        }, completion: { (finished) in
            
            self.taskCollectionView.scrollToItem(at: insertIndexPath, at:.right, animated: false)
        })
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return self.scrapImportHelper.numberOfTask
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    
        let taskCell : TSTaskCell = collectionView.dequeueReusableCell(withReuseIdentifier: "TaskCell", for: indexPath) as! TSTaskCell
        
        taskCell.scrapInfo = self.scrapImportHelper.scrapAt(indexPath: indexPath)
        
        return taskCell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        guard let scrapInfo = self.scrapImportHelper.scrapAt(indexPath: indexPath) else { return }
        
        TSScrapNavigator.sharedInstance.append(scrapInfo:scrapInfo)
        
        self.scrapImportHelper.removeScrapAt(indexPath: indexPath)
        
        self.taskCollectionView.performBatchUpdates({
            
            self.taskCollectionView.deleteItems(at: [indexPath])
            
        }, completion: { (finished) in
           
        })
    }
}

