//
//  DataCenter.swift
//  1119ReHackathon
//
//  Created by 황재욱 on 2017. 11. 19..
//  Copyright © 2017년 황재욱. All rights reserved.
//

import Foundation


class DataCenter{
    
    /// 싱글턴 static 변수
    static var main = DataCenter()
    
    // MARK: - Properties
    /// 메인화면에 보여져야 할 모든 알람아이템들이 들어가야 할 배열
    var alarmInfoList: [AlarmItem] = []
    /// 알람아이템들이 저장될 파일
    let AlarminfoFileName = "AlarmInfomation.plist"
    /// AlarminfoFile이 저장된 위치를 가리키는 URL
    var documentUrl: URL {
        return FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!.appendingPathComponent(AlarminfoFileName)
    }
    /// AlarminfoFile이 저장된 위치를 가리키는 String
    var documentPath: String {
        return NSSearchPathForDirectoriesInDomains(.documentDirectory,
                                            .userDomainMask, true).first! + "/" + AlarminfoFileName
    }
    
    private init(){
        copyFormFromBundle()
        loadData()
    }
    
    /// 번들에서 얻어낸 plist를 카피해서 다큐먼트에 저장
    func copyFormFromBundle() {
        guard let bundlePath = Bundle.main.url(forResource: "AlarmInfomation",
                                               withExtension: "plist") else { return }
        if !FileManager.default.fileExists(atPath: documentPath){
            do{
                try FileManager.default.copyItem(at: bundlePath, to: documentUrl)
            }catch {
                print("\(AlarminfoFileName) copy failed")
            }
        }
    }

    /// 파일에서 뽑아낸 데이터를 alarmInfoList 객체에 저장
    func loadData() {
        guard let documentRenewedPlistURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent(AlarminfoFileName) else { return }
        
        if let data = NSArray(contentsOf: documentRenewedPlistURL) {
            let decoder = PropertyListDecoder()
            var alarmData:[AlarmItem] = []
            
            for item in data as! [Data]{
                if let dataFromDocu = try? decoder.decode(AlarmItem.self, from: item as! Data){
                    alarmData.append(dataFromDocu)
                }
            }
            self.alarmInfoList = alarmData
        }
    }
    
     /**
     초기화면 우측하단의 초승달을 눌렀을 때, 실행되어야 할 알람
     1. 오늘의 알람들을 시간순으로 정렬하고,
     2. 가장 빨리 울릴 알람들부터 "현재시간"과 비교해서
     3. 현재시간보다 늦게 울린다면, 그 알람을 리턴
     4. 오늘의 알람 모두가 "현재시간"보다 빨리 울린다면 내일 가장 먼저 울릴 알람을 리턴
     5. 내일 울릴 알람이 아예 없다면 nil을 리턴
     */
    var nearestAlarm:AlarmItem?{
        get{
            let today = Day(rawValue:Calendar.current.component(.weekday, from: Date()))!
            let tomorrow = Day(rawValue:Calendar.current.component(.weekday, from:
                Date(timeInterval: 24*60*60, since: Date())))!
            
            for item in AlarmItem.availableAlarms(on: today, given: alarmInfoList){
                if item.timeToWakeUp > Date().absoluteSeconds{
                    return item
                }
            }
            let alarmsOfTomorrow = AlarmItem.availableAlarms(on: tomorrow, given: alarmInfoList)
            if alarmsOfTomorrow.count > 0 {
                return alarmsOfTomorrow[0]
            }else{
                return nil
            }
        }
    }
}
