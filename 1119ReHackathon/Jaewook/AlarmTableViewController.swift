//
//  AlarmTableViewController.swift
//  1119ReHackathon
//
//  Created by 황재욱 on 2017. 11. 19..
//  Copyright © 2017년 황재욱. All rights reserved.
//

import UIKit


class AlarmTableViewController: UIViewController {
    
    // MARK : IBOutlets
    @IBOutlet weak var minusBtn: UIButton!
    @IBOutlet weak var sidevarBtn: UIButton!
    @IBOutlet weak var tableView: UITableView!
    
    // MARK : Properties
    
    var cellDatas: [AlarmItem] = []
    let GOTOSETTING: String = "goToSetting"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        sidevarBtn.addTarget(self.revealViewController(), action: #selector(SWRevealViewController.revealToggle(_:)), for: .touchUpInside)
        
        self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        self.view.addGestureRecognizer(self.revealViewController().tapGestureRecognizer())
        
        makeDeleteBtn()
        cellDatas = DataCenter.main.alarmInfoList
    }
    
    @IBAction func minusBtnTapped(_ sender: UIButton) {
        tableView.isEditing = !tableView.isEditing
    }
    
    func makeDeleteBtn(){
        self.minusBtn.transform = CGAffineTransform.init(rotationAngle: CGFloat.pi / 4 )
        self.view.layoutIfNeeded()
    }
    
    @IBAction func plusBtnTapped(_ sender: UIButton){
        let data = AlarmItem()
        let path = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] + "/AlarmInfomation.plist"

        let encoder = PropertyListEncoder()
        let encodedData = try! encoder.encode(data)
        var test = NSArray(contentsOfFile: path) as! [Any]
        test.append(encodedData)
        NSArray(array: test).write(toFile: path, atomically: true)

        DataCenter.main.loadData()
        cellDatas = DataCenter.main.alarmInfoList
        tableView.reloadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        DataCenter.main.loadData()
        cellDatas = DataCenter.main.alarmInfoList
        tableView.reloadData()
    }
}






// 테이블뷰 구성

extension AlarmTableViewController: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cellDatas.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! JWCustomCell
        
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "hh : MM"
        
       let celldata = cellDatas[indexPath.row]
        
        
        
        
       
        
        cell.alarmTime.text = Date.format(seconds: celldata.timeToWakeUp, with: "HH:mm:ss")
        cell.alarmDays.text = celldata.repeatDaysString
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
//        tableView.isEditing = true
        DataCenter.main.alarmInfoList.remove(at: indexPath.item)
        cellDatas.remove(at: indexPath.item)
        tableView.deleteRows(at: [indexPath], with: .automatic)
        
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
//        let selectedData = cellDatas[indexPath.item]
//        let selectedCell = tableView.cellForRow(at: indexPath) as! JWCustomCell
//        selectedCell
        
        performSegue(withIdentifier: GOTOSETTING, sender: indexPath.item)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if let nextVC = segue.destination as? RecordingPhaseViewController {
            nextVC.alarmItem = DataCenter.main.nearestAlarm
        }
        print(sender as? Int)
        if let nextVC = segue.destination as? SetUpNavigationViewController {
            nextVC.indexOfAlarmToSetUp = sender as! Int
        }
    }
}



