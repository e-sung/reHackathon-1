//
//  AlarmItem.swift
//  1119ReHackathon
//
//  Created by 황재욱 on 2017. 11. 19..
//  Copyright © 2017년 황재욱. All rights reserved.
//

import Foundation

struct AlarmItem: Codable {
    
    /// 다음 알람시간까지의 초
    var timeToWakeUp: TimeInterval = 0
    /// 전기장판 킬 시간(단위 : 초)
    var timeToHeat:Int = 30*60
    /// 활성화 여부 : 메인화면에서, 스위치를 토글함으로써 변경.
    var isActive:Bool = true
    /// 스누즈 할 양(단위: 초)
    var snoozeAmount:Int = 15*60
    /// 이 알람이 울려야 할 날들 : [월,화,수,목,금,토,일] 중 복수선택
    var repeatDays:[Days] = [.Mon,.Tue,.Wed,.Thu,.Fri]
    
    var repeatDaysString: String {
        
        var daysString: String = ""
        
        for item in repeatDays{
            
            switch item{
            case .Sun:
                daysString += "일 "
            case .Mon:
                daysString += "월 "
            case .Tue:
                daysString += "화 "
            case .Wed:
                daysString += "수 "
            case .Thu:
                daysString += "목 "
            case .Fri:
                daysString += "금 "
            case .Sat:
                daysString += "토 "
                
            
            
            }
            
            
        }
        
        return daysString
    
    }
    
}
