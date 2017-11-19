//
//  SetUpViewController.swift
//  RaspberryAlarm
//
//  Created by 류성두 on 2017. 11. 11..
//  Copyright © 2017년 류성두. All rights reserved.
//

import UIKit
import Hero

class SetUpViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UINavigationControllerDelegate{
    
    var alarmItem:AlarmItem!
    var navControllerVC:SetUpNavigationViewController!
    
    @IBOutlet private weak var settingItemTV: UITableView!
    @IBAction private func cancelButtonHandler(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }
    @IBAction private func confirmButotnHandler(_ sender: UIBarButtonItem){
        var allData = NSArray(contentsOfFile: DataCenter.main.documentPath) as! [Any]
        let encoder = PropertyListEncoder()
        let revisedData = try! encoder.encode(alarmItem)
        allData[navControllerVC.indexOfAlarmToSetUp] = revisedData
        NSArray(array: allData).write(toFile: DataCenter.main.documentPath, atomically: true)
        
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func unwindToSetUpAlarmVC(segue:UIStoryboardSegue) {
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        settingItemTV.delegate = self
        settingItemTV.dataSource = self
        navControllerVC = navigationController as! SetUpNavigationViewController
        ///TODO!!!!!
        /// self.alarmItem = DataCenter.main.alarmItems[indexOfAlarmToSetUP] 으로 바꿔야 함!
        alarmItem = AlarmItem(timeToWakeUp: 3600, timeToHeat: 300, isActive: true, snoozeAmount: 300, repeatDays: [.Mon])
    }
}

extension SetUpViewController{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var reuseId = ""
        
        var cellTitle = ""
        var sliderValue:Float = 15.0
        switch indexPath.item {
        case 0:
            reuseId = "normalCell"
            cellTitle = "시간설정"
        case 1:
            reuseId = "normalCell"
            cellTitle = "반복설정"
        case 2:
            reuseId = "sliderCell"
            cellTitle = "스누즈 설정"
            sliderValue = Float(alarmItem.snoozeAmount/60)
        case 3:
            reuseId = "sliderCell"
            cellTitle = "전기장판 설정"
            sliderValue = Float(alarmItem.timeToHeat/60)
        default:
            print("Unidentified indexPath")
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseId)!
        if indexPath.item<2{
            cell.textLabel?.text = cellTitle
            cell.textLabel?.font = UIFont(name: (cell.textLabel?.font.fontName)!, size: CGFloat(30))
            return cell
        }else{
            let sliderCell = cell as! SliderSettingCell
            sliderCell.delegate = self
            sliderCell.title = cellTitle
            sliderCell.quantity = sliderValue
            return sliderCell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.item < 2{
            return CGFloat(70)
        }
        return CGFloat(100)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.cellForRow(at: indexPath)?.heroID = "selected"
        switch indexPath.item {
        case 0:
            performSegue(withIdentifier: "showWakeUpTimeSetUp", sender: nil)
        case 1:
            performSegue(withIdentifier: "showRepeatDaysSetUp", sender: nil)
        default:
            print("unexpected indexPath")
        }
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? WakeUpTimeSetUpViewController{
            vc.view.heroID = "selected"
            vc.timeValue = alarmItem.timeToWakeUp
        }else if let vc = segue.destination as? RepeatDaySetUpViewController{
            vc.originalRepeatingDays = alarmItem.repeatDays
        }
    }
}

extension SetUpViewController:SliderSettingCellDelegate{
    func didSliderValueChanged(_ changer: String, _ changedValue: TimeInterval) {
        if changer == "스누즈 설정"{
            self.alarmItem.snoozeAmount = changedValue*60.0
        }else{
            self.alarmItem.timeToHeat = changedValue*60.0
        }
    }
}

