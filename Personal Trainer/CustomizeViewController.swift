//
//  CustomizeViewController.swift
//  Personal Trainer
//
//  Created by kaiyue wang on 8/9/16.
//  Copyright © 2016 kaiyuewang. All rights reserved.
//

import UIKit

class CustomizeViewController: UIViewController,UITextFieldDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate {

    @IBOutlet weak var saveButton: UIBarButtonItem!
    @IBOutlet weak var workOutImage: UIImageView!
    @IBOutlet weak var workOutName: UITextField!
    
    var customizeObject:customizeData?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        workOutName.delegate=self
        checkValidMealName()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func CancelAdding(sender: AnyObject) {
dismissViewControllerAnimated(true, completion: nil)    }
    
    @IBAction func selectingFromPhotoLibrary(sender: UITapGestureRecognizer) {
        workOutName.resignFirstResponder()
        let imagePickerController = UIImagePickerController()
        imagePickerController.sourceType = .PhotoLibrary
        imagePickerController.delegate = self
        presentViewController(imagePickerController, animated: true, completion: nil)

    }
    //ImagePicker Delegat
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        let selectedImage = info[UIImagePickerControllerOriginalImage] as! UIImage
        workOutImage.image=selectedImage
        dismissViewControllerAnimated(true, completion: nil)


    }
//TextFieldDelegate
    func textFieldDidBeginEditing(textField: UITextField) {
        saveButton.enabled=false
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        // Hide the keyboard.
        textField.resignFirstResponder()
        return true
    }
    
    func checkValidMealName() {
        // Disable the Save button if the text field is empty.
        let text = workOutName.text ?? ""
        saveButton.enabled = !text.isEmpty
    }

    func textFieldDidEndEditing(textField: UITextField) {
        checkValidMealName()
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if saveButton===sender{
            let name = workOutName.text ?? ""
            let photo = workOutImage.image
            customizeObject=customizeData(name: name, image: photo)
            let destination=segue.destinationViewController as! WorkOutListTableViewController
            destination.customizeWorkOut.append(customizeObject!)
        }
    }
    
}
