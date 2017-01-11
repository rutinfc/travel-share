//
//  CustomView.swift
//  TravelShare
//
//  Created by jeongkyu kim on 2017. 1. 10..
//  Copyright © 2017년 jungk. All rights reserved.
//

import UIKit

extension UIView {
    
    func onRoundBorder() {
        self.layer.borderColor = UIColor.black.withAlphaComponent(0.5).cgColor
        self.layer.cornerRadius = 3
        self.layer.borderWidth = 1
    }
    
    func onSelectedBorder() {
        self.layer.borderColor = UIColor.red.withAlphaComponent(0.5).cgColor
        self.layer.cornerRadius = 3
        self.layer.borderWidth = 2
    }
}

enum TSTaskViewType : String {
    case none
    case preview
    case navigation
    case editor
    case subTask
    case report
}

extension TSTaskInfoProtocol {
    
    func createTaskView(_ taskInfo:TSTaskInfo, superView:UIView, viewType:TSTaskViewType) -> TSTaskView? {
        
        guard let view = TSTaskView.createTaskView(taskInfo, viewType:viewType) else { return nil }
        
        superView.addSubview(view)
        
        view.frame = superView.bounds
        
        let views = ["view":view]
        let horizon = NSLayoutConstraint.constraints(withVisualFormat:"H:|-(0)-[view]-(0)-|", options:NSLayoutFormatOptions.alignAllCenterY, metrics:nil, views:views)
        let vertical = NSLayoutConstraint.constraints(withVisualFormat:"V:|-(0)-[view]-(0)-|", options:NSLayoutFormatOptions.alignAllCenterX, metrics:nil, views:views)
        
        superView.addConstraints(horizon)
        superView.addConstraints(vertical)
        
        return view
    }
}


class TSTaskBackgroundView : UIView, TSTaskInfoProtocol {
    
    var scrapInfo: TSScrapInfo?
}

class TSTaskView : UIView, TSTaskInfoProtocol {
    
    @IBOutlet var subTaskView : UIView?
    
    var taskAppendView : TSTaskAppendView?
    
    var enableResponder : Bool = false
    
    var viewType : TSTaskViewType = .none
    
    var scrapInfo: TSScrapInfo? {
        
        set {
            
            if scrapInfo != nil {
                
                let taskInfo = TSTaskInfo(scrapInfo:scrapInfo!)
                self.taskInfo = taskInfo
            }
        }
        
        get {
            return self.taskInfo?.scrap
        }
    }
    
    var taskInfo: TSTaskInfo? {
        
        didSet {
            
            switch self.viewType {
            case .editor:
                let tapGesture = UITapGestureRecognizer.init(target: self, action: #selector(self.handleTap(_:)))
                self.addGestureRecognizer(tapGesture)
            default:
                break
            }
            
            self.taskAppendView?.taskInfo = taskInfo

            //            guard let subTask = self.taskInfo?.subTaskes else { return }
//            
//            if subTask.count == 0 {
//                return
//            }
//            
//            if self.taskAppendView == nil {
//                
//                self.addSubTaskView()
//                
//            } else {
//               
//                self.taskAppendView?.removeAllTask()
//            }
        }
    }
    
    override var canBecomeFirstResponder : Bool {
        
        get {
            return self.enableResponder
        }
    }
    
    override func becomeFirstResponder() -> Bool {
        self.onSelectedBorder()
        return super.becomeFirstResponder()
    }
    
    override func resignFirstResponder() -> Bool {
        self.onRoundBorder()
        return super.resignFirstResponder()
    }
    
    override func awakeFromNib() {
        
        super.awakeFromNib()
        
        self.onRoundBorder()
        
    }
    
    func handleTap(_ gesture:UIGestureRecognizer) {
        
        if self.enableResponder == true {
            _ = self.becomeFirstResponder()
        }
    }
    
    func addSubTaskView() {
        
        guard let subTaskView = self.subTaskView else { return }
        
        let array = UINib(nibName: "TSCustomViewes", bundle: nil).instantiate(withOwner: nil, options: nil)
        
        let identifier = "TaskAppendView"
        
        for index in array.enumerated() {
            
            if let view = index.element as? TSTaskAppendView {
                
                if view.restorationIdentifier == identifier {
                    
                    subTaskView.addSubview(view)
                    view.frame = subTaskView.bounds
                    
                    let views = ["view":view]
                    let horizon = NSLayoutConstraint.constraints(withVisualFormat:"H:|-(0)-[view]-(0)-|", options:NSLayoutFormatOptions.alignAllCenterY, metrics:nil, views:views)
                    let vertical = NSLayoutConstraint.constraints(withVisualFormat:"V:|-(0)-[view]-(0)-|", options:NSLayoutFormatOptions.alignAllCenterX, metrics:nil, views:views)
                    subTaskView.addConstraints(horizon)
                    subTaskView.addConstraints(vertical)
                    
                    self.taskAppendView = view
                }
            }
        }
    }
    
    func append(taskInfo:TSTaskInfo) {
        
        if self.taskAppendView == nil {
            
            self.addSubTaskView()
        }
        
        DispatchQueue.main.async {
            
            self.taskAppendView!.append(taskInfo: taskInfo)
        }
    }
    
    static func createTaskView(_ taskInfo:TSTaskInfo, viewType:TSTaskViewType) -> TSTaskView? {
        
        let array = UINib(nibName: "TSCustomViewes", bundle: nil).instantiate(withOwner: nil, options: nil)
        
        let identifier = taskInfo.scrap.category.rawValue + "-" + viewType.rawValue
        
        for index in array.enumerated() {
            
            if let view = index.element as? TSTaskView {
                
                if view.restorationIdentifier == identifier {
                    
                    view.viewType = viewType
                    view.taskInfo = taskInfo
                    
                    return view
                }
            }
        }
        
        return nil
    }
}

class TSTaskTitleView : TSTaskView {
    
    
}

class TSTaskAppendView : UIView, UICollectionViewDataSource {
    
    @IBOutlet var collectionView : UICollectionView?
    
    var taskInfo : TSTaskInfo?
    
    override func awakeFromNib() {
        
        super.awakeFromNib()
        
        guard let collectionView = self.collectionView else { return }
        
        collectionView.register(TSTaskCell.self, forCellWithReuseIdentifier: "TaskCell")
    }
    
    func removeAllTask() {
//        guard let taskInfo = self.taskInfo else { return }
//        taskInfo.subTaskes.removeAll()
    }
    
    func append(taskInfo:TSTaskInfo) {
        
//        guard let taskInfo = self.taskInfo else { return }
//        
//        taskInfo.subTaskes.append(taskInfo)
//        
//        let insertIndexPath = IndexPath(item: taskInfo.subTaskes.count - 1, section: 0)
//        
//        self.collectionView?.performBatchUpdates({
//            
//            self.collectionView?.insertItems(at: [insertIndexPath])
//            
//        }, completion: { (result) in
//            
//            self.collectionView?.scrollToItem(at: insertIndexPath, at:.bottom, animated: false)
//        })
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        guard let taskInfo = self.taskInfo else { return 0 }
        
        return taskInfo.scrap.subTaskes.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let taskCell : TSTaskCell = collectionView.dequeueReusableCell(withReuseIdentifier: "TaskCell", for: indexPath) as! TSTaskCell
        
//        if let taskInfo = self.taskInfo {
//            taskCell.taskInfo = taskInfo.subTaskes[indexPath.item]
//        }
        
        return taskCell
    }
}
