//
//  AlarmItem.swift
//  1119ReHackathon
//
//  Created by 황재욱 on 2017. 11. 19..
//  Copyright © 2017년 황재욱. All rights reserved.
//

import Foundation

struct AlarmItem: Codable {
    
    struct AlarmItem {
        /// 일어날 시간 : (Hour, Minute)
        var timeToWakeUp:(Int,Int)
        /// 전기장판 킬 시간(단위 : 초)
        var timeToHeat:Int = 30*60
        /// 활성화 여부 : 메인화면에서, 스위치를 토글함으로써 변경.
        /// - ToDo : 사실 스위치 토글은 아직 구현 안 됬음
        var isActive:Bool = true
        /// 스누즈 할 양(단위: 초)
        var snoozeAmount:Int = 15*60
        /// 이 알람이 울려야 할 날들 : [월,화,수,목,금,토,일] 중 복수선택
       
        var repeatDays:[Days] = [.Mon,.Tue,.Wed,.Thu,.Fri]
        /// 일어날 시간을 초로 환산.
       
        var wakeUpTimeInSeconds:Int{
            get{
                return self.timeToWakeUp.0*3600 + self.timeToWakeUp.1*60
            }
        }
    }
}
