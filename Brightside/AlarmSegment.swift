//
//  Alarm.swift
//  Brightside
//
//  Created by 90304566 on 2/24/20.
//  Copyright © 2020 90304593. All rights reserved.
//

import UIKit

class AlarmSegment {
    
    var musicFile: String
    var position: Int
    var totalNotifs: Int
    var center: UNUserNotificationCenter
    var isFirst: Bool
    
    
    init(musicFile: String, position: Int, totalNotifs: Int, center: UNUserNotificationCenter, isFirst: Bool) {
        self.musicFile = musicFile
        self.position = position
        self.totalNotifs = totalNotifs
        self.center = center
        self.isFirst = isFirst
    }
    
    func schedule (whenToPlay: Date) {
        
        let content = UNMutableNotificationContent()
        content.title = "Mr. Brightside"
        
        content.body = "Notification \(position) of \(totalNotifs)"
        
        content.sound = UNNotificationSound.init(named: UNNotificationSoundName(rawValue: musicFile + "\(position)"))
        
        let dateComponents = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute, .second], from: whenToPlay) //convert classEnd Date to dateComponents
        
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: false)
        
        var request: UNNotificationRequest
        
        if isFirst {
            request = UNNotificationRequest(identifier: dateComponents.description + " first", content: content, trigger: trigger)
        } else {
            request = UNNotificationRequest(identifier: dateComponents.description, content: content, trigger: trigger)
        }
        
        
        print("Scheduled for Hours: \(dateComponents.hour!), Minutes: \(dateComponents.minute!), Seconds: \(dateComponents.second!)")
        
        center.add(request)
        
    }
}
