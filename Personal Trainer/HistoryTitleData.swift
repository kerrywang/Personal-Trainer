//
//  HistoryTitleData.swift
//  Personal Trainer
//
//  Created by kaiyue wang on 7/28/16.
//  Copyright © 2016 kaiyuewang. All rights reserved.
//

import UIKit

class HistoryTitle:NSObject, NSCoding
{
    var Date:String
    var title:[String]
    
    struct  HistoryProperty {
        static let namekey="Date"
        static let titlekey="title"
    }
    
    static let DocumentsDirectory = NSFileManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.URLByAppendingPathComponent("HistoryTitle")
    
    
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(Date,forKey: HistoryProperty.namekey)
        aCoder.encodeObject(title,forKey: HistoryProperty.titlekey)
    }
    required convenience init?(coder aDecoder: NSCoder) {
        let Date = aDecoder.decodeObjectForKey(HistoryProperty.namekey) as! String
        
        // Because photo is an optional property of Meal, use conditional cast.
        let title = aDecoder.decodeObjectForKey(HistoryProperty.titlekey) as! [String]
        
        
        // Must call designated initializer.
        self.init(myDate: Date, mytitle: title)
    }

    init?(myDate:String,mytitle:[String])
    {
        Date=myDate
        title=mytitle
        super.init()
    }
}
