//
//  WorkOutEntry.swift
//  Personal Trainer
//
//  Created by kaiyue wang on 7/24/16.
//  Copyright © 2016 kaiyuewang. All rights reserved.
//


//KeyBoard Issue Unresolved

import UIKit

class WorkOutEntry: UITableViewController, UITextFieldDelegate {
    
    @IBOutlet weak var saveButton: UIBarButtonItem!
    
    var canEdit=true
    var workOutList=[data]()
    var sectionHeight:Int=30
    var weight=[Int]()
    override func viewDidLoad() {
      //  super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
//        saveButton.enabled=false
//        NSNotificationCenter.defaultCenter().addObserver(self,selector:#selector(WorkOutEntry.keyboardWillShow(_:)),name: UIKeyboardWillShowNotification,object : nil)
//       NSNotificationCenter.defaultCenter().addObserver(self,selector:#selector(WorkOutEntry.keyboardWillHide(_:)),name: UIKeyboardWillHideNotification,object : nil)
//}
        if(tableView.numberOfSections != 0){
            for item  in tableView.visibleCells
            {
                (item as! WorkOutTableCell).theWeightEntry.userInteractionEnabled=false
            }
        }

    }
    override func viewWillAppear(animated: Bool) {
        self.tableView.setEditing(canEdit, animated: true)

    }
    deinit {
        // perform the deinitialization
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
//    func keyboardWillShow(notification: NSNotification) {
//            if let userInfo = notification.userInfo {
//            if let keyboardSize = (userInfo[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.CGRectValue() {
//                var frame = tableView.frame
//                UIView.beginAnimations(nil, context: nil)
//                UIView.setAnimationBeginsFromCurrentState(true)
//                UIView.setAnimationDuration(0.3)
//                frame.size.height -= keyboardSize.height
//                tableView.frame=frame
//                let indexPath=tableView.indexPathForSelectedRow
//                let activetextfield=(tableView.cellForRowAtIndexPath(indexPath!) as! WorkOutTableCell).theWeightEntry
//                if activetextfield != nil{
//                    let rect = tableView.convertRect(activetextfield.bounds, fromView: activetextfield)
//                    tableView.scrollRectToVisible(rect, animated: false)
//                }
//                UIView.commitAnimations()
//                
//            }
//        }
//    }
//    
//    func keyboardWillHide(notification: NSNotification) {
//        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.CGRectValue() {
//            var frame = tableView.frame
//            UIView.beginAnimations(nil, context: nil)
//            UIView.setAnimationBeginsFromCurrentState(true)
//            UIView.setAnimationDuration(0.3)
//            frame.size.height += keyboardSize.height
//            tableView.frame = frame
//            UIView.commitAnimations()
//        }
//    }
       override func scrollViewDidScroll(scrollView: UIScrollView) {
        if(tableView.numberOfSections != 0){
            for item in tableView.visibleCells
            {
                (item as! WorkOutTableCell).theWeightEntry.userInteractionEnabled=false
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
        return workOutList.count
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return workOutList[section].SetNumber
    }
    
    //Mark: Manage Table View Delegate
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return workOutList[section].Name
    }
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return false
    }

    override func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 61.0
    }
  
       override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if workOutList[indexPath.section].weight.count==0{
        for _ in 0..<workOutList[indexPath.section].SetNumber{
            workOutList[indexPath.section].weight.append(0)
        }}
        
      //  print(workOutList[indexPath.section]!.SetNumber)
        print(workOutList[indexPath.section].weight.count)
     let cell = tableView.dequeueReusableCellWithIdentifier("workOutCell", forIndexPath:indexPath) as! WorkOutTableCell
        let number=workOutList[indexPath.section].weight[indexPath.row]
        
         cell.theWeightEntry.delegate = self;
         cell.theWeightEntry.text = String(number)
        

     return cell
     }
    
       override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let selectedCell=tableView.cellForRowAtIndexPath(indexPath) as! WorkOutTableCell
        selectedCell.theWeightEntry.delegate = self
        selectedCell.theWeightEntry.userInteractionEnabled = true
        selectedCell.theWeightEntry.becomeFirstResponder()
    }
    
    
    
    //Mark TextField Delegate
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        // Hide the keyboard.
        let indexPath=tableView.indexPathForSelectedRow
        let selectedCell=tableView.cellForRowAtIndexPath(indexPath!) as! WorkOutTableCell
        let selectedrow=indexPath!.row
        let selectedsection=indexPath!.section
        workOutList[selectedsection].weight[selectedrow]=Int(selectedCell.theWeightEntry.text!)!
        textField.resignFirstResponder()
        textField.userInteractionEnabled=false
        return true
    }
    
//    func textFieldShouldEndEditing(textField: UITextField) -> Bool {
//        if textField.resignFirstResponder()
//        {
//            let indexPath=tableView.indexPathForSelectedRow
//            let selectedCell=tableView.cellForRowAtIndexPath(indexPath!) as! WorkOutTableCell
//            let selectedrow=indexPath!.row
//            let selectedsection=indexPath!.section
//            workOutList[selectedsection].weight[selectedrow]=Int(selectedCell.theWeightEntry.text!)!
//            return true
//        }
//        return false
//    }
         func textFieldDidEndEditing(textField: UITextField) {
        //checkValidMealName()
        textField.userInteractionEnabled=false

    }
    
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        var updatedTextString : NSString = textField.text! as NSString
        updatedTextString = updatedTextString.stringByReplacingCharactersInRange(range, withString: string)
        let indexPath=tableView.indexPathForSelectedRow
        let selectedrow=indexPath!.row
        let selectedsection=indexPath!.section
        if updatedTextString as String != ""{
            workOutList[selectedsection].weight[selectedrow]=Int(updatedTextString as String)!}
        return true

            }
    
    func textFieldDidBeginEditing(textField: UITextField) {
        // Disable the Save button while editing.
        //saveButton.enabled = false
        //Disable Selectin of other rows unitil user press return
        
    }
    
    
    

}
//
