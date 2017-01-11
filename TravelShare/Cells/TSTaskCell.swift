//
//  TaskCells.swift
//  TravelShare
//
//  Created by jeongkyu kim on 2017. 1. 10..
//  Copyright © 2017년 jungk. All rights reserved.
//

import UIKit

class TSTaskCell : UICollectionViewCell, TSTaskInfoProtocol {
    
    var taskView : TSTaskView?
    var viewType : TSTaskViewType = .preview
    
    var scrapInfo : TSScrapInfo? {
        
        didSet {
            
            guard let info = self.scrapInfo else { return }
            
            let taskInfo = TSTaskInfo(scrapInfo:info)
            taskInfo.scrap = info
            
            if self.taskView == nil {
                
                self.taskView = self.createTaskView(taskInfo, superView:self.contentView, viewType:self.viewType)
                self.taskView?.isUserInteractionEnabled = false
                return
            }
            
            if self.taskView!.taskInfo?.scrap.category == info.category {
                
                self.taskView!.taskInfo = taskInfo

                return;
            }
            
            if self.taskView != nil {
                self.taskView!.removeFromSuperview()
            }
            
            self.taskView = self.createTaskView(taskInfo, superView:self.contentView, viewType:self.viewType)
        }
    }
}
