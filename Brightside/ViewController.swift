//
//  ViewController.swift
//  Brightside
//
//  Created by 90304593 and 90304566 on 1/31/20.
//  Copyright © 2020 90304593 and 90304566. All rights reserved.

import UIKit
import UserNotifications

class ViewController: UIViewController {
    @IBOutlet weak var activateButton: UIButton!
    @IBOutlet weak var dateController: UIDatePicker!
    @IBOutlet weak var enterButton: UIButton!
    @IBOutlet weak var setEndClassButton: UIButton!
    @IBOutlet weak var clearButton: UIButton!
    @IBOutlet weak var viewScheduledButton: UIButton!
    
    var now = Date()
    let musicFile = "BluePt"
    let totalNotifs = 9
    let calendar = Calendar.current
    let weekday = Calendar.current.component(.weekday, from: Date()) //Wed = 4, starts at Sun
    var classEnd = Date()
    let nowDelay = 10
    var sendPlay = Date()
    
    let center = UNUserNotificationCenter.current()
    
    let userDefaults = UserDefaults.standard
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        // Alert with instructions
        let alertController = UIAlertController(title: "For Alarms to Function Properly", message: "Device Must Be Locked With the Ringer On", preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Ok", style: .default))
        
        self.present(alertController, animated: true, completion: nil)
        
        // Create new array in user defaults \iff one is not already made
        if userDefaults.array(forKey: "alarmsList") == nil {
            userDefaults.set([Alarm](), forKey: "alarmsList")
        }
        
        //enterButton.backgroundColor = .clear
        enterButton.layer.cornerRadius = 15
        enterButton.layer.borderWidth = 1
        //enterButton.layer.borderColor = UIColor.black.cgColor
        //enterButton.layer.opacity = CGFloat(.5)
        
        activateButton.layer.cornerRadius = 15
        activateButton.layer.borderWidth = 1
        
        setEndClassButton.layer.cornerRadius = 15
        setEndClassButton.layer.borderWidth = 1
        
        clearButton.layer.cornerRadius = 15
        clearButton.layer.borderWidth = 1
        
        viewScheduledButton.layer.cornerRadius = 15
        viewScheduledButton.layer.borderWidth = 1
        
        
        
        center.requestAuthorization(options: [.alert, .sound]) {(granted, error) in
            if granted {
                print("yay, universal authorization")
            }
            else {
                print ("cringe")
            }
        }
        
    }
    
    func createAlarm (whenToPlay: Date, musicFile: String, totalNotifs: Int) {
        
        let alarm = Alarm(whenToPlay: whenToPlay, musicFile: musicFile, totalNotifs: totalNotifs, center: center)
        
        alarm.schedule()
        printPending(requests: getPending())
        showDelivered()
        
        
        //Retrieve UserDefault list
        /*var alarmsList = userDefaults.array(forKey: "alarmsList") ?? [Alarm]()
         alarmsList.append(alarm)
         
         userDefaults.set(alarmsList, forKey: "alarmsList")*/
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
    
    
    /*func createAlarm (_ whenToPlay: Date) {
     
     let content = UNMutableNotificationContent()
     content.title = "BlueSky"
     
     for index in 1...totalNotifs {
     
     content.body = "Notification \(index) of \(totalNotifs)"
     
     content.sound = UNNotificationSound.init(named: UNNotificationSoundName(rawValue: "BluePt\(index).mp3"))
     
     let dateComponents = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute, .second], from: whenToPlay.addingTimeInterval(Double(index - 1)*30)) //convert classEnd Date to dateComponents
     
     let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: false)
     let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
     
     center.add(request){ (error) in
     if error != nil {
     print("bruh")
     }
     else {
     print ("noice")
     }
     }
     
     // Retrieve UserDefault list
     var alarmsList = userDefaults.stringArray(forKey: "alarmsList") ?? [String]()
     
     print("Scheduled for Hours: \(dateComponents.hour!), Minutes: \(dateComponents.minute!), Seconds: \(dateComponents.second!)")
     alarmsList.append("Scheduled for Hours: \(dateComponents.hour!), Minutes: \(dateComponents.minute!), Seconds: \(dateComponents.second!)")
     userDefaults.set(alarmsList, forKey: "alarmsList")
     }
     }*/
    
    @IBAction func enterButtonPressed(_ sender: Any) {
        
        /*let inputDate = Calendar.current.dateComponents([.hour, .minute, .second], from: dateController.date)
         
         classEnd = calendar.date( //8:20
         bySettingHour: inputDate.hour!,
         minute: inputDate.minute!,
         second: inputDate.second!,
         of: now)!*/
        
        /*let inputInterval = Calendar.current.dateComponents([.hour, .minute], from: dateController.date)
         
         let notifSettingDate = Date()
         classEnd = notifSettingDate.addingTimeInterval(Double(inputInterval.hour!)*3600.0 + Double(inputInterval.minute!)*60.0)*/
        
        sendPlay = Date().addingTimeInterval(dateController.countDownDuration)
        center.requestAuthorization(options: [.alert, .sound]) {(granted, error) in
            if granted {
                print("yay, local authorization")
                self.createAlarm(whenToPlay: self.sendPlay, musicFile: self.musicFile, totalNotifs: self.totalNotifs)
            }
            else {
                print ("cringe")
            }
        }
    }
    
    @IBAction func activateButtonPressed(_ sender: Any) {
        
        sendPlay = Date().addingTimeInterval(Double(nowDelay))
        
        center.requestAuthorization(options: [.alert, .sound]) {(granted, error) in
            if granted {
                print("yay, local authorization")
                self.createAlarm(whenToPlay: self.sendPlay, musicFile: self.musicFile, totalNotifs: self.totalNotifs)
            }
            else {
                print ("cringe")
            }
        }
        
        let alertController = UIAlertController(title: "ALERT", message: "Lock Device Within \(nowDelay) Seconds", preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Ok", style: .default))
        
        self.present(alertController, animated: true, completion: nil)
        
    }
    
    @IBAction func setEndOfClass(_ sender: Any) {
        if (weekday == 1 || weekday == 7){
            print("It's the weekend, relax!")
        } else if (weekday == 3){
            classEnd = calendar.date(
                bySettingHour: 11,
                minute: 16,
                second: 30,
                of: now)!
            print("Tuesday")
        } else {
            classEnd = calendar.date(
                bySettingHour: 10,
                minute: 48,
                second: 30,
                of: now)!
            print("not Tuesday")
        }
        
        center.requestAuthorization(options: [.alert, .sound]) {(granted, error) in
            if granted {
                print("yay, local authorization")
                self.createAlarm(whenToPlay: self.classEnd, musicFile: self.musicFile, totalNotifs: self.totalNotifs)
            }
            else {
                print ("cringe")
            }
        }
        
    }
    
    @IBAction func clearButtonPressed(_ sender: Any) {
        for alarm in (userDefaults.array(forKey: "alarmsList") ?? [Alarm]()) {
            print((alarm as! Alarm).name)
        }
        
        print("Cleared")
        
        center.removeAllDeliveredNotifications()
        center.removeAllPendingNotificationRequests()
        
        userDefaults.set([Alarm](), forKey: "alarmsList")
        
        printPending(requests: getPending())
        showDelivered()
        
    }
    
}



