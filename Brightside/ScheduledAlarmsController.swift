//
//  ScheduledAlarmsController.swift
//  Mr. Brightside
//
//  Created by 90304566 on 2/11/20.
//  Copyright © 2020 90304593. All rights reserved.
//
// This is a test comment

import UIKit

class ScheduledAlarmsController: UIViewController {
    
    @IBOutlet weak var alarmsListLabel: UILabel!
    
    var alarmsList = [Alarm]()
    let testvar = 1
    
    override func viewDidLoad() {
        
        //self.navigationController?.isNavigationBarHidden = false
        
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        alarmsListLabel.text = ""
        
        //refreshes screen
        print("Refreshing...")
        
        fillAlarmsList()
        
    }
    
    func fillAlarmsList() {
        if getPending().count < 1 {
            alarmsListLabel.text = "Sorry! No alarms scheduled!"
            alarmsList = [Alarm]()
        } else {
            for request in getPending() {
                if request.identifier.hasSuffix("first") { //finds the first AlarmSegment in each Alarm object, string added in AlarmSegment's request identifier
                    /*alarmsList.append(Alarm(whenToPlay: request.identifier, musicFile: request.content.sound.debugDescription, totalNotifs: 9, center: UNUserNotificationCenter.current()))*/
                }
            }
        }
    }
    
    func getPending() -> [UNNotificationRequest] {
        var requestsList = [UNNotificationRequest]()
        UNUserNotificationCenter.current().getPendingNotificationRequests(completionHandler: {requests -> () in
            print("\(requests.count) Requests")
            for request in requests{
                print(request.identifier)
                requestsList.append(request)
            }
        })
        return requestsList
    }
    
    func printPending(requests: [UNNotificationRequest]) {
        for request in requests {
            print(request.identifier)
        }
    }
    
    func showDelivered() {
        UNUserNotificationCenter.current().getDeliveredNotifications(completionHandler: {deliveredNotifications -> () in
            print("\(deliveredNotifications.count) Delivered notifications")
            for notification in deliveredNotifications{
                print(notification.request.identifier)
            }
        })
    }
}
