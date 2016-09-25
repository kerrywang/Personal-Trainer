//
//  ExisitingPlanTableViewController.swift
//  Personal Trainer
//
//  Created by kaiyue wang on 7/29/16.
//  Copyright © 2016 kaiyuewang. All rights reserved.
//

import UIKit

class ExisitingPlanTableViewController: UITableViewController {

    var existingPlans:[exsistingPlanData] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.rightBarButtonItem = editButtonItem()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func viewWillAppear(animated: Bool) {
        if let savedexistingPlans=loadstoredList(){
            existingPlans+=savedexistingPlans
        }

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
        return existingPlans.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("existingPlan", forIndexPath: indexPath)

        // Configure the cell...
        cell.textLabel!.text = existingPlans[indexPath.row].chosenName
        print("Exist")
        storeSavedList()
        return cell
    }
    

 
    
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            existingPlans.removeAtIndex(indexPath.row)// Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
            storeSavedList()
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    

    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        let indexPath=tableView.indexPathForSelectedRow
        let destinationController=segue.destinationViewController as! ExistingPlanDetailTableViewController
        destinationController.existingPlanDetail=existingPlans[indexPath!.row].savedList
        destinationController.savedTitle=existingPlans[indexPath!.row].chosenName
    }
    
    func storeSavedList(){
        let isSuccessfulSave = NSKeyedArchiver.archiveRootObject(existingPlans, toFile: exsistingPlanData.ArchiveURL.path!)
        if !isSuccessfulSave {
            print("Failed to save meals...")
        }
    }
    
    func loadstoredList()->[exsistingPlanData]?
    {
        
        return (NSKeyedUnarchiver.unarchiveObjectWithFile(exsistingPlanData.ArchiveURL.path!) as? [exsistingPlanData])
        
    }

}
