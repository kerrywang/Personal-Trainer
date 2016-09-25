//
//  exisitingPlanData.swift
//  Personal Trainer
//
//  Created by kaiyue wang on 7/30/16.
//  Copyright © 2016 kaiyuewang. All rights reserved.
//

import UIKit

class exsistingPlanData:NSObject,NSCoding{
    var savedList:[customizeData]
    var chosenName:String
    struct propertykey
    {
        static let savedListkey="savedList"
        static let chosedName="chosenName"
    }
    
    static let DocumentsDirectory=NSFileManager().URLsForDirectory(.DocumentDirectory, inDomains:.UserDomainMask).first!
    
    static let ArchiveURL = DocumentsDirectory.URLByAppendingPathComponent("existingPlans")
    
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(savedList, forKey:propertykey.savedListkey)
        aCoder.encodeObject(chosenName, forKey: propertykey.chosedName)
    }
    
    init?(save:[customizeData],name:String) {
        self.savedList=save
        self.chosenName=name
        
        super.init()
    }

    required convenience init?(coder aDecoder:NSCoder) {
        let List=aDecoder.decodeObjectForKey(propertykey.savedListkey)as! [customizeData]
        let Name=aDecoder.decodeObjectForKey(propertykey.chosedName) as! String
        
        self.init(save: List,name: Name)
    }
    
    
     }