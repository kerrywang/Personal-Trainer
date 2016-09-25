//
//  WorkOutListTableViewController.swift
//  Personal Trainer
//
//  Created by kaiyue wang on 7/26/16.
//  Copyright © 2016 kaiyuewang. All rights reserved.
//

import UIKit
//need to disable continue button if none is selected




class WorkOutListTableViewController: UITableViewController {
    var customizeWorkOut:[customizeData]=[]
    let chestWorkOut:[String]=["Butterfly","Decline Barbell Bench Press","Decline Dumbbell Bench Press","Flat Barbell Chest Press","Incline Barbell Bench Press","Incline Dumbbell Bench Press","Incline Chest Press Machine","Leverage Chest Press Machine"]
    let abdominalWorkOut:[String]=["AB Crunch Machine","Cable Crunch","Press SitUp"]
    let bicepWorkOut:[String]=["Hammer Curl","Incline Dumbbell Curl","Concentration Curl","Preacher Curl"]
//    let calfWorkOut:[String]=["Calf Press","Leg Press Machine","Standing Calf Raise"]
//    let HamstringWorkOut:[String]=["Dead Lift","Lying Leg Curl","Seated Leg Curl","Standing Leg Curl"]
//    let backWorkOut:[String]=["Machine Assisted Pull Up","Leverage Iso Row","Bent Over One-Arm Bar Row","Incline Bench Pull","Seated Back Extension","Stiff Leg Barbell Good Morning","T-Bar Row With Handle"]
//    let tricepWorkOut:[String]=["Bench Press","Decline Skull Crusher","Dip Machine","Machine Tricep Extention"]
//    let DeltaWorkOut:[String]=["Anti-Gravity Press","BarBell Front Raise","BarBell Incline Shoulder Raise","Leverage Shoulder Press","BarBell Militarty Press"]
    var allWorkOut:[[customizeData]]=[] //storing all the workOut
    var workOutCategory:[String]=[]// setting header
    var selectedCell:Int = 0
    
    var chest:[customizeData]=[]
    func chestWorkOutData(){
        for i in chestWorkOut{
            let photo=UIImage(named: i)
            let chestItem=customizeData(name: i, image: photo)
            chest.append(chestItem!)
        }
    }
    var abdominal:[customizeData]=[]
    func abdominalWorkOutData(){
        for i in abdominalWorkOut{
            let photo=UIImage(named: i)
            let abdominalItem=customizeData(name: i, image: photo)
            abdominal.append(abdominalItem!)
        }
    }

    var bicep:[customizeData]=[]
    func bicepWorkOutData(){
        for i in bicepWorkOut{
            let photo=UIImage(named: i)
            let bicepItem=customizeData(name: i, image: photo)
            bicep.append(bicepItem!)
        }
    }

    @IBOutlet weak var saveWorkOut: UIBarButtonItem!
    @IBOutlet weak var continuebutton: UIBarButtonItem!
    
    @IBAction func saveWorkOutPlan(sender: AnyObject) {
        let alertControl=UIAlertController(title: "Add Plan",message:"Enter a Title For Your Plan",preferredStyle: UIAlertControllerStyle.Alert )
        
        alertControl.addTextFieldWithConfigurationHandler({(textField:UITextField!)in textField.placeholder="Title"
            textField.keyboardType=UIKeyboardType.Default})
        
        let YesalertAction=UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: {(alertaction:UIAlertAction) in
            let mytext = alertControl.textFields![0].text
            if mytext != ""{
                self.save(mytext!)}
        
        })
        let NoalertAction=UIAlertAction(title:"Cancel",style: UIAlertActionStyle.Cancel,handler:nil)
        alertControl.addAction(YesalertAction)
        alertControl.addAction(NoalertAction)
        presentViewController(alertControl,animated: true,completion: nil)
    }
    
    
    func save(mytext:String){
        
            let ExisitingPlanController=self.storyboard?.instantiateViewControllerWithIdentifier("existingPlan") as! ExisitingPlanTableViewController
            
            if let indexarray=tableView.indexPathsForSelectedRows{
            var selectedworkOut:[customizeData]=[]
            for i in indexarray
            {
                let eachWorkOutTitle = allWorkOut[i.section][i.row]
                selectedworkOut.append(eachWorkOutTitle)
                }
            
            let newPlan=exsistingPlanData(save: selectedworkOut,name: mytext)
            ExisitingPlanController.existingPlans.append(newPlan!)
            self.navigationController?.pushViewController(ExisitingPlanController, animated: true)
        }
    }
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        if let savedData=loadCustomizeList(){
            customizeWorkOut+=savedData
        }
        createData()
        continuebutton.enabled=false
        saveWorkOut.enabled=false

  
    }
    func createData()
    {
        //write in data
        chestWorkOutData()
        abdominalWorkOutData()
        bicepWorkOutData()
        
        allWorkOut.append(customizeWorkOut)
        workOutCategory.append("Customize")
        //append data to allworkOut
        allWorkOut.append(chest)
        workOutCategory.append("Chest")
//        allWorkOut.append(DeltaWorkOut)
//        workOutCategory.append("Delta")
        allWorkOut.append(abdominal)
        workOutCategory.append("Abdominal")
        allWorkOut.append(bicep)
        workOutCategory.append("Bicep")
//        allWorkOut.append(tricepWorkOut)
//        workOutCategory.append("Tricep")
//        allWorkOut.append(backWorkOut)
//        workOutCategory.append("Back")
//        allWorkOut.append(calfWorkOut)
//        workOutCategory.append("Calf")
//        allWorkOut.append(HamstringWorkOut)
//        workOutCategory.append("HamString")
        
       

    }
        override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        print("the totoal number of sections is:\(allWorkOut.count)")
        return allWorkOut.count
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        print("the total number of row in section \(section), is \(allWorkOut[section].count)")
        return allWorkOut[section].count
    }

    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return workOutCategory[section]
    }
    override func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 61
    }
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("workOutSelection", forIndexPath: indexPath)
        let title=allWorkOut[indexPath.section][indexPath.row].nameEntry
        
        cell.textLabel?.text=title

            // Configure the cell...
        let workOutImage=allWorkOut[indexPath.section][indexPath.row].imageEntry
        cell.imageView!.image=workOutImage
        saveCustomizeList()

        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        selectedCell+=1
        continuebutton.enabled=true
        saveWorkOut.enabled=true
        
    }
    override func tableView(tableView: UITableView, didDeselectRowAtIndexPath indexPath: NSIndexPath) {
        selectedCell-=1
        if selectedCell<=0
        {
            continuebutton.enabled=false
            saveWorkOut.enabled=false
        }
    }
    //Mark: -NSCoding
    func saveCustomizeList(){
        let isSuccessfulSave = NSKeyedArchiver.archiveRootObject(customizeWorkOut, toFile: customizeData.ArchiveURL.path!)
        if !isSuccessfulSave {
            print("Failed to save meals...")
        }
    }
    func loadCustomizeList()->[customizeData]?{
        return NSKeyedUnarchiver.unarchiveObjectWithFile(customizeData.ArchiveURL.path!) as? [customizeData]
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller
        if(segue.identifier=="desiredSet"){
        var workOutTitle=[String]()
        var currentWorkOut:String=""
        let indexarray=tableView.indexPathsForSelectedRows
        let destination=segue.destinationViewController as! SetAmountTableViewController
      //  print(allWorkOut[indexarray![2].section][indexarray![0].row]
        for i in (indexarray)!
        {
            let sampleData=data(Name: "meaninglessString",SetNumber: 0,Weight: [],Photo: nil)
            let desiredName=allWorkOut[i.section][i.row].nameEntry
            let desiredPhoto=allWorkOut[i.section][i.row].imageEntry
            sampleData?.Name=desiredName
            sampleData?.photo=desiredPhoto
            destination.workOutDetail.append(sampleData!)
            
            if(currentWorkOut != workOutCategory[i.section]){ workOutTitle.append(workOutCategory[i.section])
            currentWorkOut=workOutCategory[i.section]
            }
        }
        
        //print(workOutTitle.count)
        let historyController=self.storyboard?.instantiateViewControllerWithIdentifier("HistoryView") as!HistoryTableViewController
        historyController.workOutTitle.append(workOutTitle)
        self.navigationController?.pushViewController(historyController, animated: false)
        }

        //print(historyController.workOutTitle.count)
        
    }
    

  }
