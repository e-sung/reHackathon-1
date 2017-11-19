//
//  AlarmItem.swift
//  1119ReHackathon
//
//  Created by 황재욱 on 2017. 11. 19..
//  Copyright © 2017년 황재욱. All rights reserved.
//

import Foundation

struct AlarmItem: Codable {
    
    /// 일어날 시간 (단위 : 초 / 기준 : 0시0분0초)
    var timeToWakeUp: TimeInterval = 0
    /// 전기장판 킬 시간(단위 : 초 / 기준 : 일어날 시간)
    var timeToHeat:TimeInterval = 30.0*60.0
    /// 활성화 여부 : 메인화면에서, 스위치를 토글함으로써 변경.
    /// - ToDo : 현시점에서 그냥 무늬만 있는 상태. 세부내용 구현 필요
    var isActive:Bool = true
    /// 스누즈 할 시간
    var snoozeAmount:TimeInterval = 15.0*60.0
    /// 이 알람이 울려야 할 날들 : [월,화,수,목,금,토,일] 중 복수선택
    var repeatDays:[Day] = [.Mon,.Tue,.Wed,.Thu,.Fri]
    /// repeatDays를 문자열로 변환하는 연산속성
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
    
    /**
     주어진 alarms 배열을 필터링하여 , 특정 day에 울리는 알람들의 배열을 반환
     
     - parameter day : 필터 기준
     - parameter alarms : 필터 대상
     - parameter shouldBeSorted : true로 설정하면, "가장 먼저 울릴 순"으로 정렬된 배열이 나옴
     */
    static func availableAlarms(on day:Day, given alarms:[AlarmItem], sorted:Bool = true)->[AlarmItem]{
        var alarmsToReturn:[AlarmItem] = []
        for item in alarms{
            if item.repeatDays.contains(day){
                alarmsToReturn.append(item)
            }
        }
        if sorted == true {
            alarmsToReturn.sort { (item1 , item2) -> Bool in
                let wt1 = item1.timeToWakeUp
                let wt2 = item2.timeToWakeUp
                return wt1 < wt2
            }
        }
        return alarmsToReturn
    }
    
}
