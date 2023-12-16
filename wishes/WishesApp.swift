//
//  WishesApp.swift
//  Wishes
//
//  Created by MaxOS on 11.12.2023.
//

import SwiftUI
import UserNotifications
import UIKit


@main
struct WishesApp: App {
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    var body: some Scene {
        WindowGroup {
            WishesView()
        }
    }
}
