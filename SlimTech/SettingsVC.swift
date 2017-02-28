//
//  SettingsVC.swift
//  SlimTech
//
//  Created by Dawsen Richins on 2/18/17.
//  Copyright © 2017 Droplet. All rights reserved.
//

import UIKit

class SettingsVC: UIViewController {
    
    @IBOutlet weak var timeAlertSwitch: UISwitch!
    @IBOutlet weak var percentAlertSwitch: UISwitch!
    
    @IBOutlet weak var timeAlertPicker: UIDatePicker!
    
    @IBOutlet weak var saveButton: UIButton!
    
    @IBOutlet weak var timeAlertLabel: UILabel!
    @IBOutlet weak var percentAlertLabel: UILabel!
    
    @IBOutlet weak var percentUsageTextEntry: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.black
        timeAlertPicker.setValue(UIColor.white, forKeyPath: "textColor")
        timeAlertPicker.timeZone = NSTimeZone.local
        
        saveButton.isHidden = true
        
        timeAlertPicker.isHidden = true
        
        percentUsageTextEntry.isHidden = true
        
        
        
    }

    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    //this function allows views to be erased rather than simply stacked upon
    @IBAction func backButtonPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }

    @IBAction func timeAlertSwitchPressed(_ sender: Any) {
        if(timeAlertSwitch.isOn){
            timeAlertPicker.isHidden = false
            saveButton.isHidden = false
        }
        else{
            
            timeAlertPicker.isHidden = true
            saveButton.isHidden = true
            timeAlertLabel.text = "Daily Usage Reminder"
        }
    }
    
    //setting provided in storyboard for when a percent usage reminder needs to be set
    //programmatically created a done button because storyboard didn't have environment needed for impolementation
    
    @IBAction func percentAlertSwitchPressed(_ sender: Any) {
        
        if (percentAlertSwitch.isOn == true){
            let keyPadDone = UIToolbar.init()
            keyPadDone.sizeToFit()
            let keyPadButtonDone = UIBarButtonItem.init(barButtonSystemItem: UIBarButtonSystemItem.done,
                                                  target: self, action: #selector(SettingsVC.donePressed(_:)))
            
            keyPadDone.items = [keyPadButtonDone] // You can even add cancel button too
            percentUsageTextEntry.inputAccessoryView = keyPadDone
            percentUsageTextEntry.isHidden = false
            percentUsageTextEntry.keyboardType = UIKeyboardType.numberPad
            percentUsageTextEntry.becomeFirstResponder()
        }
        else{
            percentAlertLabel.text = "Percent Cap Reminder"
            percentUsageTextEntry.isHidden = true
            percentUsageTextEntry.resignFirstResponder()
        }
        
    }
    
    //done button programmatically created (not present in storyboard)
    //done button allows for exit procedures when the user has entered a percent usage reminder
    
    @IBAction func donePressed(_ sender: Any) {
        if(percentUsageTextEntry.hasText == false || Int(percentUsageTextEntry.text!)!>100){
            percentAlertSwitch.isOn = false
        }
        else{
            percentAlertLabel.text = "Percent Cap Reminder: \(percentUsageTextEntry.text!)%"
        }
        
        percentUsageTextEntry.resignFirstResponder()
        percentUsageTextEntry.isHidden = true
        
        
    }
    
    
    @IBAction func saveButtonPressed(_ sender: Any) {
        saveButton.isHidden = true
        if(timeAlertPicker.isHidden == false){
            var hour = timeAlertPicker.value(forKeyPath: "hour") as? Int
            var minute = timeAlertPicker.value(forKeyPath: "minute") as? Int
            var minuteString = ""
            var hourString = ""
            
            if (minute!<10){
                minuteString = "0\(minute!)"
            }
            else{
                minuteString = "\(minute!)"
            }
            
            if (hour!>=12){
                if (hour! == 12){
                    hour! += 0
                }
                else{
                    hour! -= 12
                }
                hourString = "\(hour!)"
                timeAlertLabel.text = "Usage Reminder   " + hourString + ":" + minuteString + " PM"
                
            }
            else{
                if (hour! == 0){
                    hour! += 12
                }
                hourString = "\(hour!)"
                timeAlertLabel.text = "Usage Reminder   " + hourString + ":" + minuteString + " AM"
            }
            timeAlertPicker.isHidden = true
        }
    }
    
    
    
    
    
}
