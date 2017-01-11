//
//  TSScrapNaviCell.swift
//  TravelShare
//
//  Created by jeongkyu kim on 2017. 2. 14..
//  Copyright © 2017년 jungk. All rights reserved.
//

import UIKit

class TSScrapNaviCell : UICollectionViewCell, TSTaskInfoProtocol {
    
    @IBOutlet var leftSpace : NSLayoutConstraint!
    @IBOutlet var taskBoundView : UIView!
    
    var taskView : TSTaskView?
    
    var scrapInfo: TSScrapInfo? {
        
        set {
            
        }
        
        get {
            
            guard let taskInfo = self.taskInfo else {
                return nil
            }
            
            return taskInfo.scrap
        }
    }
    
    var depth : Int {
        
        didSet {
            
            
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        
        self.depth = 1
        
        super.init(coder: aDecoder)
        
        self.contentView.backgroundColor = UIColor.gray
    }
    
    override var isSelected : Bool {
        
        didSet {
            
            if self.isSelected {
                self.contentView.backgroundColor = UIColor.yellow
            } else {
                self.contentView.backgroundColor = UIColor.gray
            }
        }
    }
    
    var taskInfo : TSTaskInfo? {
        
        didSet {
            
            guard let taskInfo = self.taskInfo else {
                self.taskView?.removeFromSuperview()
                self.taskView = nil
                return
            }
            
            if taskInfo.depth == 1 {
                self.leftSpace.constant = 0
            } else {
                self.leftSpace.constant = (CGFloat(taskInfo.depth - 1) * CGFloat(10))
            }
            
            if self.taskView == nil {
                
                self.taskView = self.createTaskView(taskInfo, superView:self.taskBoundView, viewType:.navigation)
                self.taskView?.isUserInteractionEnabled = false
                return
            }
            
            if self.taskView!.taskInfo?.scrap.category == taskInfo.scrap.category {
                self.taskView!.taskInfo = taskInfo
                return;
            }
            
            self.taskView?.removeFromSuperview()
            self.taskView = self.createTaskView(taskInfo, superView:self.taskBoundView, viewType:.navigation)
        }
    }
}
