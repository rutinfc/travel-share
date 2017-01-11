//
//  TSScrapInfo.swift
//  TravelShare
//
//  Created by jeongkyu kim on 2017. 2. 14..
//  Copyright © 2017년 jungk. All rights reserved.
//

import Foundation

enum TSScrapCategory : String {
    case empty
    case title
    case date
    case address
    case map
    case text
    case photo
    case drawing
    
    static func random() -> TSScrapCategory {
        
        let value = Int(arc4random_uniform(2))
        
        switch value {
        case 0:
            return .empty;
        case 1:
            return .title;
        default:
            return .empty
        }
        
        //        switch value {
        //        case 1:
        //            return .title;
        //        case 2:
        //            return .date;
        //        case 3:
        //            return .address;
        //        case 4:
        //            return .map;
        //        case 5:
        //            return .text;
        //        case 6:
        //            return .photo;
        //        case 7:
        //            return .drawing;
        //        default:
        //            return .empty
        //        }
    }
}

class TSScrapInfo {
    
    var scrapId : String = NSUUID().uuidString.lowercased()
    var category : TSScrapCategory = .empty
    var subTaskes : Array<TSScrapInfo> = Array()
    var parentTask : TSScrapInfo?
    
    func equals (compareTo:TSScrapInfo) -> Bool {
        
        return self.scrapId == compareTo.scrapId
    }
}
