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
            } else {
               print("Нет данных")
            }
            
            
        }
    }
    
    func scheduleNotification(title: String, body: String, time: Date) {
        if isOnSwitchNotification {
            let content = UNMutableNotificationContent()
            content.title = title
            content.body = body
            content.sound = UNNotificationSound.default
            
            let component = Calendar.current.dateComponents([.hour, .minute], from: time)
            let trigger = UNCalendarNotificationTrigger(dateMatching: component, repeats: true)
            let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
            
            UNUserNotificationCenter.current().add(request)
            
        } else {
            
            UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
            print("Уведомления выключены")
        }
    }
}
