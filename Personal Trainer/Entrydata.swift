//
//  Entrydata.swift
//  Personal Trainer
//
//  Created by kaiyue wang on 7/24/16.
//  Copyright © 2016 kaiyuewang. All rights reserved.
//

import UIKit
class data:NSObject,NSCoding
{
    //Mark Property
    var Name:String
    var SetNumber:Int
    var weight:[Int]
    var photo:UIImage?
    //Mark Type
    struct propertyKey
    {
        static let nameKey="Name"
        static let numberKey="SetNumber"
        static let weightKey="weight"
        static let imageKey="photo"
    }
    
    // MARK: Archiving Paths
    
    static let DocumentsDirectory = NSFileManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.URLByAppendingPathComponent("data")
    
    
    
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(Name,forKey: propertyKey.nameKey)
        aCoder.encodeObject(SetNumber,forKey: propertyKey.numberKey)
        aCoder.encodeObject(weight,forKey: propertyKey.weightKey)
        aCoder.encodeObject(photo,forKey: propertyKey.imageKey)
    }
    required convenience init?(coder aDecoder: NSCoder) {
        let Name = aDecoder.decodeObjectForKey(propertyKey.nameKey) as! String
        
        // Because photo is an optional property of Meal, use conditional cast.
        let SetNumber = aDecoder.decodeObjectForKey(propertyKey.numberKey) as! Int
    
        let weight = aDecoder.decodeObjectForKey(propertyKey.weightKey) as! [Int]
        
        let photo=aDecoder.decodeObjectForKey(propertyKey.imageKey)as? UIImage
        
        // Must call designated initializer.
        self.init(Name: Name, SetNumber: SetNumber, Weight: weight,Photo: photo)
    }
    
    
    init?(Name:String,SetNumber:Int,Weight:[Int],Photo:UIImage?)
    {
        self.Name=Name
        self.SetNumber=SetNumber
        self.weight=Weight
        self.photo=Photo
        for _ in 0..<self.SetNumber{
            self.weight.append(0)
        }
        
        super.init()
        
        if Name.isEmpty || SetNumber < 0 {
            return nil
        }

    }
    
    
   }
