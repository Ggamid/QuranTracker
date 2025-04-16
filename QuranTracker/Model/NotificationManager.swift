//
//  NotificationManager.swift
//  QuranTracker
//
//  Created by Gamıd Khalıdov on 29.12.2024.
//

import Foundation
import UserNotifications

class NotificationManager {
    static let shared = NotificationManager()
    
    func requestAuthorization() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound]) { _, _ in }
    }
    
    func scheduleNotification() {
        let content = UNMutableNotificationContent()
        content.title = "Quran Tracker"
        content.body = "Не забудьте прочитать сегодня Коран!"
        content.sound = .default
        
        var dateComponents = DateComponents()
        dateComponents.hour = 12

        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
        let request = UNNotificationRequest(identifier: "1", content: content, trigger: trigger)
        
        UNUserNotificationCenter.current().add(request)
    }
    
    func cancelNotification() {
        UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
        UNUserNotificationCenter.current().removeAllDeliveredNotifications()
    }
}
