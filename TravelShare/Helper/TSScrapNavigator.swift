//
//  TSScrapNavigator.swift
//  TravelShare
//
//  Created by jeongkyu kim on 2017. 2. 14..
//  Copyright © 2017년 jungk. All rights reserved.
//

import Foundation

extension NSNotification.Name {
 
    public static let TSScrapNavigationChanged : NSNotification.Name = NSNotification.Name("TSScapNavigationChanged")
}

class TSScrapNavigator {
    
    static let sharedInstance = TSScrapNavigator()
    
    var taskInfoes : Array = [TSTaskInfo]()
    var selectedTaskInfo : TSTaskInfo?
    
    var numberOfSection:Int {
        
        get {
            return 1
        }
    }
    
    func numberOfItemIn(section:Int) -> Int {
        
        return self.taskInfoes.count
    }
    
    func taskInfoAt(indexPath:IndexPath) -> TSTaskInfo? {
        
        if self.taskInfoes.count <= indexPath.item {
            return nil
        }
        
        let taskInfo = self.taskInfoes[indexPath.item]
        
        return taskInfo
    }
    
    func append(scrapInfo:TSScrapInfo) {
        
        var depth = 1
        var index = self.taskInfoes.count
        
        if let selectedTaskInfo = self.selectedTaskInfo {
            
            depth += selectedTaskInfo.depth
            
            selectedTaskInfo.scrap.subTaskes.append(scrapInfo)
            scrapInfo.parentTask = selectedTaskInfo.scrap
            
            if let selectedIndex = self.taskInfoes.index(where: { (taskInfo) -> Bool in
                
                return (selectedTaskInfo.taskId == taskInfo.taskId)
                
            }) {
                
                index = selectedIndex + 1
            }
        }
        
        let taskInfo = TSTaskInfo(scrapInfo:scrapInfo)
        
        taskInfo.depth = depth
        
        self.taskInfoes.insert(taskInfo, at:index)
        
        NotificationCenter.default.post(name: .TSScrapNavigationChanged, object: nil)
    }
    
    func selectedScrap(scrapInfo:TSScrapInfo) -> Bool {
        
        if let selectedTaskInfo = self.selectedTaskInfo {
            
            return selectedTaskInfo.scrap.equals(compareTo: scrapInfo)
        }
        
        return false
    }
    
    func selectedScrapAt(indexPath:IndexPath) {
        
        if self.taskInfoes.indices.contains(indexPath.item) == false {
            return;
        }
        
        let taskInfo = self.taskInfoes[indexPath.item]
        
        self.selectedTaskInfo = taskInfo
    }
    
    func deselectedScrapAt(indexPath:IndexPath) {
        
        if self.taskInfoes.indices.contains(indexPath.item) == false {
            return;
        }
        
        let taskInfo = self.taskInfoes[indexPath.item]
        
        if taskInfo.taskId == self.selectedTaskInfo?.taskId {
            self.selectedTaskInfo = nil
        }
    }
}
