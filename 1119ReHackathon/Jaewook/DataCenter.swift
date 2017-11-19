//
//  DataCenter.swift
//  1119ReHackathon
//
//  Created by 황재욱 on 2017. 11. 19..
//  Copyright © 2017년 황재욱. All rights reserved.
//

import Foundation


class DataCenter{
    
    // MARK: 싱글턴 static 변수
    
    static var main = DataCenter()
    
    // MARK: - Properties
    
    var alarmInfoList: [AlarmItem] = []
    
    let AlarminfoFileName = "AlarmInfomation.plist"
    var documentUrl: URL {
        return FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!.appendingPathComponent(AlarminfoFileName)
    }
    var documentPath: String {
        return NSSearchPathForDirectoriesInDomains(.documentDirectory,
                                            .userDomainMask, true).first! + "/" + AlarminfoFileName
    }
    
    private init(){
        copyFormFromBundle()
        loadData()
        
    }
    
    
    // 번들에서 plist 카피해서 다큐먼트에 넣기
    
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
    
    
    // 데이터 로드하기
    
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
    
    // 가장 가까운 시간 계산
    
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
