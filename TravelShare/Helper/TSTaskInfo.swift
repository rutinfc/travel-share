//
//  TSTaskInfo.swift
//  TravelShare
//
//  Created by jeongkyu kim on 2017. 1. 11..
//  Copyright © 2017년 jungk. All rights reserved.
//

import Foundation

protocol TSTaskInfoProtocol {
    var scrapInfo : TSScrapInfo? {set get}
}

class TSTaskInfo {
    
    var taskId : String = NSUUID().uuidString.lowercased()
    var focused : Bool = false
    var scrap : TSScrapInfo
    var depth : Int
    
    init(scrapInfo:TSScrapInfo) {
        self.scrap = scrapInfo
        self.depth = 1
    }
}
