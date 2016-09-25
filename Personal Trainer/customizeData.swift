//
//  customizeData.swift
//  Personal Trainer
//
//  Created by kaiyue wang on 8/9/16.
//  Copyright © 2016 kaiyuewang. All rights reserved.
//

import UIKit

class customizeData:NSObject,NSCoding
{
    var nameEntry:String
    var imageEntry:UIImage?
    
    struct propertyKey{
       static let nameKey = "nameEntry"
        static let imageKey = "imageEntry"
    }
    static let DocumentsDirectory=NSFileManager().URLsForDirectory(.DocumentDirectory, inDomains:.UserDomainMask).first!
    
    static let ArchiveURL = DocumentsDirectory.URLByAppendingPathComponent("customData")
    
    init?(name:String,image:UIImage?){
        nameEntry=name
        imageEntry=image
        super.init()
    }
    
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(nameEntry, forKey: propertyKey.nameKey)
        aCoder.encodeObject(imageEntry, forKey: propertyKey.imageKey)
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        let name = aDecoder.decodeObjectForKey(propertyKey.nameKey) as! String
        
        // Because photo is an optional property of Meal, use conditional cast.
        let photo = aDecoder.decodeObjectForKey(propertyKey.imageKey) as? UIImage
        
        
        // Must call designated initializer.
        self.init(name: name, image: photo)
    }

    
}
