//
//  HistoryTableViewController.swift
//  Personal Trainer
//
//  Created by kaiyue wang on 7/25/16.
//  Copyright © 2016 kaiyuewang. All rights reserved.
//

//
//  HistoryTableViewController.swift
//  Personal Trainer
//
//  Created by kaiyue wang on 7/24/16.
//  Copyright © 2016 kaiyuewang. All rights reserved.
//

import UIKit

class HistoryTableViewController: UITableViewController {
    
    var workOutTitle=[[String]]()
    var DateHistory=[String]()
    var Histroytitle=[HistoryTitle]()
    
    var workoutlist:[data] = []
    var history=[[data]]()
    override func viewDidLoad() {
        super.viewDidLoad()

//        let backButton = UIBarButtonItem(title: "", style: UIBarButtonItemStyle.Plain, target: navigationController, action: nil)
//        navigationItem.leftBarButtonItem = backButton
        navigationItem.leftBarButtonItem = editButtonItem()

        if let savedhistory=loadData(),let savedtitle=loadHistoryTitleData()
        {
            Histroytitle+=savedtitle
            history+=savedhistory
            
        }

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        //print(history.count)
        return history.count
    }
    
   @IBAction func unwindtoHistory(sender:UIStoryboardSegue)
    {
        //print("here")
        if let sourceViewController = sender.sourceViewController as? WorkOutEntry      {
          
            workoutlist=sourceViewController.workOutList
            let newIndexPath = NSIndexPath(forRow: history.count, inSection: 0)
            history.append(workoutlist)
            //set Date array
            let dateFormatter = NSDateFormatter()
            dateFormatter.dateFormat = "MM-dd-YYYY"
            let Date=dateFormatter.stringFromDate(NSDate())
            DateHistory.append(Date)
            
            for i in 0..<DateHistory.count{
            let NewHistorytitle=HistoryTitle(myDate: DateHistory[i], mytitle: workOutTitle[i])
            Histroytitle.append(NewHistorytitle!)
            }
            
            tableView.insertRowsAtIndexPaths([newIndexPath], withRowAnimation: .Bottom)
            saveData()
            saveHistorytitleData()
            
        }
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        //print("i am")
        let cell = tableView.dequeueReusableCellWithIdentifier("HistoryEntry", forIndexPath: indexPath) as!HistoryTableViewCell
        
       // cell.workOutDate.text=DateHistory[indexPath.row]
        cell.workOutDate.text=Histroytitle[indexPath.row].Date

        var text:String=""
        let a=indexPath.row
        print("a=\(a)")
        print(Histroytitle.count)
            for j in Histroytitle[indexPath.row].title{
                text+=" \(j)/"
            }
        
        cell.workOutType.text=text
        
        // Configure the cell...
        
        return cell
    }
    
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }

    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete{
            history.removeAtIndex(indexPath.row)
            Histroytitle.removeAtIndex(indexPath.row)
            saveHistorytitleData()
            saveData()
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Fade)
        }
    }
    
    
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
        if(segue.identifier=="showDetail")
        {
            print("here")
            let DestinationViewController=segue.destinationViewController as! WorkOutEntry
            DestinationViewController.canEdit=true
            DestinationViewController.saveButton.enabled=false
            DestinationViewController.saveButton.tintColor=UIColor.clearColor()
            if let selectedCell = sender as? HistoryTableViewCell
            {
                print("i'm")
                let indexPath=tableView.indexPathForCell(selectedCell)
                DestinationViewController.workOutList=history[indexPath!.row]
            }
        }
    }
    
    //Mark: -NSCoding
    func  saveData()  {
        let isSuccessfulSave = NSKeyedArchiver.archiveRootObject(history, toFile: data.ArchiveURL.path!)
        if !isSuccessfulSave {
            print("Failed to save meals...")
        }
    }
    
    func saveHistorytitleData(){
        let isSuccessfulSave = NSKeyedArchiver.archiveRootObject(Histroytitle, toFile: HistoryTitle.ArchiveURL.path!)
        if !isSuccessfulSave{
            print("Failed to save meals...")
        }

    }
    
    func loadData()->[[data]]?
    {
        return NSKeyedUnarchiver.unarchiveObjectWithFile(data.ArchiveURL.path!) as? [[data]]

    }
    
    func loadHistoryTitleData()->[HistoryTitle]?{
        return (NSKeyedUnarchiver.unarchiveObjectWithFile(HistoryTitle.ArchiveURL.path!) as? [HistoryTitle])!
    }
    
}
