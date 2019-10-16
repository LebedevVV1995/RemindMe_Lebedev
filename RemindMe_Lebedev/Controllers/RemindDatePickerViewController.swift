//
//  RemindDatePickerViewController.swift
//  RemindMe_Lebedev
//
//  Created by Владимир on 14/10/2019.
//  Copyright © 2019 Владимир. All rights reserved.
//
//
import UIKit
import UserNotifications

class RemindDatePickerViewController: UIViewController, UNUserNotificationCenterDelegate {
    var dateFormatter : DateFormatter!
    var pickerString: String?
    var nowString: String?
    
    func sendNotification(){
        let center = UNUserNotificationCenter.current()
        let options: UNAuthorizationOptions = [.alert, .sound];
        center.requestAuthorization(options: options) {
            (granted, error) in
            if !granted {
                print("Something went wrong")
            }
        }
        center.getNotificationSettings { (settings) in
            if settings.authorizationStatus != .authorized {
                // Notifications not allowed
            }
        }
        let content = UNMutableNotificationContent()
        
        content.title = "Don't forget"
        content.body = "Finish it app!"
        content.sound = UNNotificationSound.default
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5,
                                                        repeats: false)
        
        let identifier = "UYLLocalNotification"
        let request = UNNotificationRequest(identifier: identifier,
                                            content: content, trigger: trigger)
        center.delegate = self
        center.add(request, withCompletionHandler: { (error) in
            if error != nil {
                print("error")
            }
        })
    }
    
    @IBOutlet var dateLabel: UILabel!
    @IBOutlet weak var vew: UIView!


    override func viewDidLoad() {
        super.viewDidLoad()
        
        let datePicker : UIDatePicker = UIDatePicker(frame: CGRect(x: 0,y: 330,width: self.view.frame.size.width,height: 220))
        datePicker.datePickerMode = UIDatePicker.Mode.dateAndTime
        datePicker.locale = Locale(identifier: "en_GB")
        self.view.addSubview(datePicker)
        
        datePicker.addTarget(self, action: #selector(RemindDatePickerViewController.change(_:)), for: UIControl.Event.valueChanged)
        
        dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "YYYY-MM-dd hh:mm"
        //dateFormatter.dateStyle
        let _ = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { (timer) in
            if self.dateFormatter.string(from: Date()) == self.dateLabel.text {
                self.sendNotification()
            }
        }
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                willPresent notification: UNNotification,
                                withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) ->    Void) {
        completionHandler([.alert, .badge, .sound])
    }
    
    @IBAction func closeBtn(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    @IBAction func change(_ sender : UIDatePicker)
    {
         pickerString = dateFormatter.string(from: sender.date)
         nowString = dateFormatter.string(from: Date())
         dateLabel.text = pickerString
    }
}

