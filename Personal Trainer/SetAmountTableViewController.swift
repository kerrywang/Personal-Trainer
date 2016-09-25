//
//  SetAmountTableViewController.swift
//  Personal Trainer
//
//  Created by kaiyue wang on 7/27/16.
//  Copyright © 2016 kaiyuewang. All rights reserved.
//

import UIKit

class SetAmountTableViewController: UITableViewController,UITextFieldDelegate {
    var workOutDetail=[data]()
    var selectedWorkOutType=[String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        if(tableView.numberOfSections != 0){
            for item  in tableView.visibleCells
            {
                (item as! SetTableViewCell).setNum.userInteractionEnabled=false
            }
        }

}
    override func viewWillAppear(animated: Bool) {
    }
    
    override func scrollViewDidScroll(scrollView: UIScrollView) {
        if(tableView.numberOfSections != 0){
            for item in tableView.visibleCells
            {
                (item as! SetTableViewCell).setNum.userInteractionEnabled=false
            }
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
        return workOutDetail.count
    }
    override func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 10
    }
    override func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("setNum", forIndexPath: indexPath) as! SetTableViewCell
        cell.Label.text = workOutDetail[indexPath.row].Name
        if let myimage=workOutDetail[indexPath.row].photo{
            cell.TheImage.image = myimage}
        cell.setNum.delegate=self
        cell.setNum.text = String(workOutDetail[indexPath.row].SetNumber)
        
        return cell
    }

    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let selectedCell=tableView.cellForRowAtIndexPath(indexPath) as! SetTableViewCell
        selectedCell.setNum.delegate = self
        selectedCell.setNum.userInteractionEnabled = true
        selectedCell.setNum.becomeFirstResponder()
    }


    ///Text Field Delegate
    func textFieldDidEndEditing(textField: UITextField) {
        //checkValidMealName()
        textField.userInteractionEnabled=false
        
    }

    
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        var updatedTextString : NSString = textField.text! as NSString
        updatedTextString = updatedTextString.stringByReplacingCharactersInRange(range, withString: string)
        let indexPath=tableView.indexPathForSelectedRow
        let selectedrow=indexPath!.row
        if updatedTextString as String != ""{
            workOutDetail[selectedrow].SetNumber=Int(updatedTextString as String)!}
        return true
        
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let DestinationController=segue.destinationViewController as! WorkOutEntry
        DestinationController.canEdit=false
        DestinationController.workOutList=workOutDetail
    }
    

}
