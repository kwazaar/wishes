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
    @Published var date: Int = 0
    @Published var isOnSwitchNotification = false
    
    init() {
        getLocalWish()
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
                let wish = wishesDecode.first!.value
                self.wish = wish
                self.wishes = wishesDecode
            } else {
               print("Нет данных")
            }
        }
    }
    
    func setNotification(time: Date) {
        if isOnSwitchNotification {
            for dayNumber in 0..<wishes.count {
                let content = UNMutableNotificationContent()
                content.title = NotificationTitle.title[dayNumber]
                content.body = wishes[dayNumber].value
                content.sound = UNNotificationSound.default
                let timeNotification = time.addingTimeInterval(Double(dayNumber * 86400))
                print(timeNotification)
                
                let component = Calendar.current.dateComponents([.day, .hour, .minute], from: timeNotification)
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
}
