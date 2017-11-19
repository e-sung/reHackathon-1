//
//  Days.swift
//  1119ReHackathon
//
//  Created by 황재욱 on 2017. 11. 19..
//  Copyright © 2017년 황재욱. All rights reserved.
//

import Foundation

/**
 월화수목금토일
 - Note :
 DateComponents(.day)도 Sunday를 '1'로 잡음
 특별한 이유가 있지 않으면, 여기에 설정된 rawValue를 바꾸지 말 것
 */
enum Day: Int, Codable{
    case Sun = 1
    case Mon = 2
    case Tue = 3
    case Wed = 4
    case Thu = 5
    case Fri = 6
    case Sat = 7
}
