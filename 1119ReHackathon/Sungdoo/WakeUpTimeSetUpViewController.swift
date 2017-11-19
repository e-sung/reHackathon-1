//
//  WakeUpTimeSetUpViewController.swift
//  RaspberryAlarm
//
//  Created by 류성두 on 2017. 11. 12..
//  Copyright © 2017년 류성두. All rights reserved.
//

import UIKit
import Hero

class WakeUpTimeSetUpViewController: UIViewController {

    var timeValue:TimeInterval = 3600.0*6.0
    
    override func viewDidLoad() {
        self.isHeroEnabled = true
        self.view.heroID = "selected"
        self.view.heroModifiers = [.source(heroID: "selected"), .duration(3)]
    }
    
    @IBOutlet weak var datePicker: UIDatePicker!
    
    @IBAction func goBackButtonHandler(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    @IBAction func onTimeValueChange(_ sender: UIDatePicker) {
        self.timeValue = sender.date.absoluteSeconds
    }
    @IBAction private func confirmButtonHandler(_ sender: UIButton) {
        performSegue(withIdentifier: "unwindToSetUpVC", sender: self)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let nextVC = segue.destination as! SetUpViewController
        nextVC.alarmItem.timeToWakeUp = self.timeValue
    }
}
