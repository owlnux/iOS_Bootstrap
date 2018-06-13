//
//  ViewController.swift
//  iOS_Bootstrap
//
//  Created by ams.eng@hotmail.com on 06/08/2018.
//  Copyright (c) 2018 ams.eng@hotmail.com. All rights reserved.
//  Ref : https://stackoverflow.com/questions/25738817/removing-duplicate-elements-from-an-array

/*
 
 How to use :
 
 let arrayOfInts = [2, 2, 4, 4]
 
 Remove duplicates :
 print(arrayOfInts.removeDuplicates()) // Prints: [2, 4]
 
 Filtering based on properties :
 let filteredElements = myElements.filterDuplicates { $0.PropertyOne == $1.PropertyOne && $0.PropertyTwo == $1.PropertyTwo }
 
*/

import UIKit
import iOS_Bootstrap



class ViewController: UIViewController {

    let picker = CustomPicker()
    var socialMediaManager : SocialMediaManager?

    override func viewDidLoad() {
        super.viewDidLoad()
        socialMediaManager = SocialMediaManager(context: self)
    }
    
    @IBAction func buttonGoToHomeStoryboard(_ sender: UIButton) {
        let storyboard = UIStoryboard.getStoryboardWithName(Storyboard.home.rawValue)
        let homeVC = storyboard.instantiateInitialViewController() as! HomeVC
        homeVC.x = 2
        present(homeVC, animated: true, completion: nil)
    }
    
    @IBAction func showProgress(_ sender: UIButton) {
        EZLoadingActivity.showWithDelay("Waiting...", disableUI: false, seconds: 2)
    }
    

    
    @IBAction func showPicker(_ sender: UIButton) {
       openDatePicker(sender: sender)
       // smc?.postToFacebook(text: "Hopa")
        
    }
    @IBAction func showTimePicker(_ sender: UIButton) {
        openTimePicker(sender: sender)
    }
    
    @IBAction func showLocalePicker(_ sender: UIButton) {
        openLocalePicer(sender: sender)
    }
    
    
    @IBAction func showArrayPicker(_ sender: UIButton) {
        openDataPicker(sender: sender)
    }
    
    @IBAction func showMultiArrayPicker(_ sender: UIButton) {
        openMultiDatasourcePicker(sender: sender)
    }
    
    @IBAction func showDateAndTimePicker(_ sender: UIButton) {
        openDateAndTimePicker(sender: sender)
    }
    
    @IBAction func showDataPicker(_ sender: UIButton) {
    }
    
    @IBAction func loggers(_ sender: UIButton) {
       
        Log.debug("Hi !")
        Log.error("There is an error :(")
    }
    
    
    func openMultiDatasourcePicker(sender : UIButton) {
        let dataSource : [[String]] = [["One", "Two", "A lot"], ["Many", "Many more", "Infinite"],["One", "Two", "A lot"]]
        picker.showMutiDataSelectionPicker(sender: sender, title: "", dataSource: dataSource, initislSelection: [0,0,0], okButton: nil, cancelButton: nil) { (position, result) in
            Log.info("Data " + String(position[0]))
        }
    }
    
    func openLocalePicer(sender : UIButton) {
        picker.showLocalePicker(sender: sender, title: "Locale picker", initislSelection: 0, currentLocaleButtonTitle: nil, okButton: nil, cancelButton: nil) { (timeZone) in
        }
    }
    
    func openDataPicker(sender : UIButton) {
        let rightButton = UIButton(frame: CGRect(x:0,y:0,width:30,height:30))
        rightButton.titleLabel?.font.withSize(22)
        rightButton.setTitle("Cancel", for: .normal)
        rightButton.setTitleColor(UIColor.red, for: .normal)
        
        let dataSource : [String] = ["One", "Two", "A lot"]
        
        picker.showDataSelectionPicker(sender: sender, title: "Dropdown", dataSource: dataSource, initislSelection: 0, okButton: nil, cancelButton: rightButton) { (data) in
        }
    }
    
    func openTimePicker(sender : UIButton) {
        picker.showTimePicker(sender: sender, title: "", currentLocaleButtonTitle: nil, okButton: nil, cancelButton: nil) { (date) in
            Log.info(date)
        }
    }
    
    func openDateAndTimePicker(sender : UIButton) {
        picker.showDateTimePicker(sender: sender, title: "", minimumDate: nil, maximumDate: nil, currentLocaleButtonTitle: nil, okButton: nil, cancelButton: nil) { (date) in
            Log.info(date)
        }
    }

    func openDatePicker(sender : UIButton) {
        let rightButton = UIButton(frame: CGRect(x:0,y:0,width:30,height:30))
        rightButton.titleLabel?.font.withSize(22)
        rightButton.setTitle("Ok", for: .normal)
        rightButton.setTitleColor(UIColor.blue, for: .normal)
        //
        picker.showDatePicker(sender: sender, title: "", minimumDate: nil, maximumDate: nil, currentLocaleButtonTitle: nil, okButton: rightButton, cancelButton: nil) { (date) in
            Log.info(date)
        }
    }
    
}

