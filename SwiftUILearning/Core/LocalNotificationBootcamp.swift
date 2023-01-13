//
// LocalNotificationBootcamp.swift
// SwiftUILearning
//
// Created by Ahmed Ali
//

import CoreLocation
import SwiftUI
import UserNotifications

class NotificationsManager {
    static let instance = NotificationsManager()
    private init() {}
    
    func requestAuthorization() {
        let options: UNAuthorizationOptions = [.alert, .badge, .sound]
        UNUserNotificationCenter.current().requestAuthorization(options: options) { (success, error) in
            print("Success: \(success) Error: \(String(describing: error))")
        }
    }
    
    func scheduleNotification() {
        let content = UNMutableNotificationContent ()
        content.title = "First notification"
        content.subtitle = "Description here"
        content.sound = .default
        content.badge = 1
        
//        // time
//        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5.0, repeats: false)
//
//        // calendar
//        var dateComponents = DateComponents()
//        dateComponents.hour = 19
//        dateComponents.minute = 26
//
//        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: false)
        
        // location
        let coords = CLLocationCoordinate2D(latitude: 40.00, longitude: 50.00)
        
        let region = CLCircularRegion(
            center: coords,
            radius: 100,
            identifier: UUID().uuidString
        )
        
        region.notifyOnEntry = true
        region.notifyOnExit = false
        
        let trigger = UNLocationNotificationTrigger(region: region, repeats: false)
        
        let request = UNNotificationRequest(
            identifier: UUID().uuidString,
            content: content,
            trigger: trigger
        )
        
        UNUserNotificationCenter.current().add(request)
    }
    
    func cancelNotifications() {
        UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
        UNUserNotificationCenter.current().removeAllDeliveredNotifications()
    }
}

struct LocalNotificationBootcamp: View {
    var body: some View {
        VStack(spacing: 40.0) {
            Button("Request permission") {
                NotificationsManager.instance.requestAuthorization()
            }
            
            Button("Schedule Notification") {
                NotificationsManager.instance.scheduleNotification()
            }
            
            Button("Cancel Notifications") {
                NotificationsManager.instance.cancelNotifications()
            }
        }
        .onAppear {
            UIApplication.shared.applicationIconBadgeNumber = 0
        }
    }
}

struct LocalNotificationBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        LocalNotificationBootcamp()
    }
}
