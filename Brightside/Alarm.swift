//
//  Alarm.swift
//  Brightside
//
//  Created by 90304566 on 2/24/20.
//  Copyright © 2020 90304593. All rights reserved.
//

import UIKit

class Alarm {
    
    var alarms: [AlarmSegment]
    var totalNotifs: Int
    var durationInSeconds: Int
    var whenToPlay: Date
    let dateComponents: DateComponents
    var center: UNUserNotificationCenter
    
    let name: String
    
    init(whenToPlay: Date, musicFile: String, totalNotifs: Int, center: UNUserNotificationCenter) {
        self.alarms = [AlarmSegment]()
        self.totalNotifs = totalNotifs
        self.durationInSeconds = totalNotifs * 30
        self.whenToPlay = whenToPlay
        self.dateComponents = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute, .second], from: whenToPlay) //convert classEnd Date to dateComponents
        
        self.center = center
        
        self.name = dateComponents.description
        
        for position in 1...totalNotifs {
            alarms.append(AlarmSegment(musicFile: musicFile, position: position, totalNotifs: totalNotifs, center: center, isFirst: (position == 1)))
        }
    }
    
    func schedule() {
        for index in 1...totalNotifs {
            alarms[index - 1].schedule(whenToPlay: whenToPlay.addingTimeInterval(Double(index - 1)*30))
        }
    }
}
