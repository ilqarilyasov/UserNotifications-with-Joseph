//
//  ViewController.swift
//  UserNotifications-with-Joseph
//
//  Created by Ilgar Ilyasov on 9/12/18.
//  Copyright © 2018 Lambda School. All rights reserved.
//

import UIKit
import UserNotifications

class ViewController: UIViewController, UNUserNotificationCenterDelegate {
    
    @IBOutlet weak var nameLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let center = UNUserNotificationCenter.current()
        center.delegate = self
    }
    
    func checkNotificationAuthorizationStatus() {
        UNUserNotificationCenter.current().getNotificationSettings { (settings) in
            switch settings.authorizationStatus {
            case .denied: break
                
            default:
                break
            }
        }
    }

    @IBAction func authorize(_ sender: Any) {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { (granted, error) in
            if let error = error {
                NSLog("Error reuestinh local notification Authorization: \(error)")
            }
            
            if granted {
                print("Local notifocation permission ACCESS GRANTED!")
            } else {
                print("Local notification permission DENIED!")
            }
        }
    }
    
    @IBAction func sendNotification(_ sender: Any) {
        // Uniques indentifier for the notification
        let identifier = "DailyReminder"
        
        // What are we displaying on the notification
        let content = UNMutableNotificationContent()
        content.title = "This is notification Title"
        content.body = "This is notification Body"
        content.subtitle = "This is notification Subtitle"
        
        content.badge = 1
        
        // When the notification gets shown to the user
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 2, repeats: false)
        
        // The notification
        
        let request = UNNotificationRequest(identifier: identifier, content: content, trigger: trigger)
        UNUserNotificationCenter.current().add(request) { (error) in
            if let error = error {
                NSLog("Error adding Notification: \(error)")
            }
        }
    }
    
    @IBAction func showAlert(_ sender: Any) {
        let alert = UIAlertController(title: "Hello there!", message: "This is the message of an alertController.", preferredStyle: .alert)
        let dismissAction = UIAlertAction(title: "Dismiss", style: .cancel, handler: nil)
        
        alert.addAction(dismissAction)
        
        var nameTextField: UITextField?
        
        alert.addTextField { (textField) in
            textField.placeholder = "Enter First Name:"
            nameTextField = textField
        }
        
        let saveNameAction = UIAlertAction(title: "Save Name", style: .default) { (_) in
            let name = nameTextField?.text
            self.nameLabel.text = name
        }
        
        alert.addAction(saveNameAction)
        
        present(alert, animated: true, completion: nil)
        
    }
    
    // MARK: - Delegate functions for UNUserNotifications
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.alert, .sound])
    }
    

}

