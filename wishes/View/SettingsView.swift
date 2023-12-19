//
//  Settings.swift
//  wishes
//
//  Created by MaxOS on 19.12.2023.
//

import SwiftUI

struct SettingsView: View {
    
    @ObservedObject var viewModel = WishesViewModel()
    @State var timeToPushNotifications = Date()
    
    var body: some View {
        
        VStack {
            Toggle("Включить уведомления", isOn: $viewModel.isOnSwitchNotification)
            DatePicker("Выберете время получения пожелания", selection: $timeToPushNotifications, displayedComponents: .hourAndMinute)

            Button("Сохранить") {
                viewModel.setNotification(time: timeToPushNotifications)
            }
            .padding(10)
            .background(.cyan)
            .foregroundColor(.white)
            .cornerRadius(10)
        }
        .frame(width: UIScreen.main.bounds.width - 40, height: UIScreen.main.bounds.height - 100, alignment: .topLeading)
        .padding()
    }
}

struct Settings_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
