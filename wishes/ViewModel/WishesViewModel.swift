//
//  WishesViewModel.swift
//  wishes
//
//  Created by MaxOS on 11.12.2023.
//

import Foundation
import Alamofire
import SwiftUI
import UserNotifications


class WishesViewModel : ObservableObject {

    @Published var wishes: [Wish] = []
    @Published var wish: String = ""
    @Published var firstOpenApp = UserDefaults.standard.integer(forKey: "firstOpenApp")
    @Published var numberDay = 0
    @Published var secondsInDay: Double = 86400
    @Published var selectDate = Date()
    
    @AppStorage("notificationSwitch") var isOnSwitchNotification: Bool = true
    @AppStorage("timeToPushNotification") var timeToPushNotifications: TimeInterval = Date().timeIntervalSince1970
    
    init() {
        getLocalWish()
        setSettings()
        if firstOpenApp == 0 {
            UserDefaults.standard.set(Date().timeIntervalSince1970, forKey: "firstOpenDate")
            
            firstOpenApp = 1
            UserDefaults.standard.set(firstOpenApp, forKey: "firstOpenApp")
        }
        
    }
    func setSettings() {
        selectDate = Date(timeIntervalSince1970: timeToPushNotifications)
    }
    
    func getWishes() {
        
        NetworkService.shared.fetchWishes { result in
            switch result {
            case .success(let fetchWishes):
                self.wishes = fetchWishes
                self.wish = fetchWishes.first!.value
                print(self.wish)
            case .failure(let failure):
                print(failure.localizedDescription)
            }
        }
    }
    
    func getLocalWish() {
        if let url = Bundle.main.url(forResource: "Wishes", withExtension: "json") {
            
            let data = try! Data(contentsOf: url)
            guard let wishesDecode = try? JSONDecoder().decode([Wish].self, from: data) else { return }
            if wishesDecode.count > 0 {
                let wish = wishesDecode[numberDay].value
                self.wish = wish
                self.wishes = wishesDecode
            } else {
               print("Нет данных")
            }
        }
    }
    
    func setNotification() {
        if isOnSwitchNotification {
            for dayNumber in 0..<wishes.count {
                let content = UNMutableNotificationContent()
                
                content.title = NotificationTitle.title[dayNumber]
                content.body = wishes[dayNumber].value
                content.sound = UNNotificationSound.default
                let timeNotification = timeToPushNotifications + (Double(dayNumber) * secondsInDay)
                let convertTime = Date(timeIntervalSince1970: timeNotification)
                print(convertTime)
                let component = Calendar.current.dateComponents([.day, .hour, .minute], from: convertTime)
                let trigger = UNCalendarNotificationTrigger(dateMatching: component, repeats: false)
                let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
                
                UNUserNotificationCenter.current().add(request)
            }
            
        } else {
            
            UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
            UNUserNotificationCenter.current().removeAllDeliveredNotifications()
            print("Уведомления выключены")
        }
    }
    func testFunc() {
        calculateNumberDay()
    }
    
    func calculateNumberDay() {
        let date = Date().timeIntervalSince1970
        let firstOpenDate = UserDefaults.standard.double(forKey: "firstOpenDate")
        numberDay = Int((date - firstOpenDate) / secondsInDay)
        print(numberDay)
        
        
    }
}
