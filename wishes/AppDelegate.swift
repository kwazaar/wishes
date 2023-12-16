//
//  AppDelegate.swift
//  wishes
//
//  Created by MaxOS on 16.12.2023.
//

import Foundation
import SwiftUI
import UserNotifications
import UIKit


class AppDelegate: NSObject, UIApplicationDelegate, UNUserNotificationCenterDelegate {
    
    
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { granted, error in
                    if granted {
                        UNUserNotificationCenter.current().delegate = self
                    } else {
                        print("Уведомления выключены пользователем")
                    }
        }
        return true
        }
    
}
