//
//  TSScrapImportHelper.swift
//  TravelShare
//
//  Created by jeongkyu kim on 2017. 1. 11..
//  Copyright © 2017년 jungk. All rights reserved.
//

import Foundation

class TSScrapImportHelper {
    
    var scrapList:Array = [TSScrapInfo]()
    
    var numberOfTask : Int{
        
        get {
            return self.scrapList.count
        }
    }
    
    func scrapAt(indexPath:IndexPath) -> TSScrapInfo? {
        
        if self.scrapList.count <= indexPath.item {
            return nil
        }
    
        return self.scrapList[indexPath.item]
    }
    
    func removeScrapAt(indexPath:IndexPath) {
        self.scrapList.remove(at:indexPath.item)
    }
    
    func addScrap(_ scrap:TSScrapInfo) {
        
        self.scrapList.append(scrap)
    }
    
}
