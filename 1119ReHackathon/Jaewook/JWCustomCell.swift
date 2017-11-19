//
//  JWCustomCell.swift
//  SJKHackathon
//
//  Created by 황재욱 on 2017. 11. 10..
//  Copyright © 2017년 황재욱. All rights reserved.
//

import UIKit
import SnapKit

class JWCustomCell: UITableViewCell {

    @IBOutlet weak var alarmTime: UILabel!
    @IBOutlet weak var alarmDays: UILabel!
    
    var cellAlarmData: AlarmItem?
    var switchClosure : (() -> ())?
   
    var alarmisOn: Bool = false {
        willSet{
            self.alarmSwitch.isOn = newValue
        }
    }

    var alarmSwitch: UISwitch = {
        var alarmswitch = UISwitch(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
        alarmswitch.isOn = false
        return alarmswitch
    }()

    override func awakeFromNib() {
        super.awakeFromNib()
        // alarmSwitch.addTarget(self, action: #selector(switchChanged), for: .valueChanged)
        self.addSubview(alarmSwitch)
        setConstraintSwitch()
    }
    
    @objc func setSwitchClosure( newclosure:(@escaping () -> ()) ) {
        self.switchClosure = newclosure
    }

    @objc func switchChanged(){
        self.switchClosure?()
    }
    
    private func setConstraintSwitch() {
        self.alarmSwitch.snp.makeConstraints { (make) in
            make.top.equalTo(self.snp.top).offset(40)
            make.right.equalTo(self.snp.right).offset(-30)
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}


