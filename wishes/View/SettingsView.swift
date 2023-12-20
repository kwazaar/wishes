//
//  Settings.swift
//  wishes
//
//  Created by MaxOS on 19.12.2023.
//

import SwiftUI

struct SettingsView: View {
    
    @ObservedObject var viewModel = WishesViewModel()
    
    var body: some View {
        
        VStack {
            List{
                Toggle("Включить уведомления", isOn: $viewModel.isOnSwitchNotification)
                    .onChange(of: viewModel.isOnSwitchNotification) { newValue in
                        if newValue {
                            viewModel.setNotification()
                        } else {
                            viewModel.setNotification()
                        }
                    }
                if viewModel.isOnSwitchNotification {
                    DatePicker("Время уведомления", selection: Binding<Date>(get: {
                        viewModel.selectDate
                    }, set: { newValue in
                        viewModel.timeToPushNotifications = newValue.timeIntervalSince1970
                        viewModel.isOnSwitchNotification = false
                        
                    }) , displayedComponents: .hourAndMinute)
                }
                
            }
        }
    }
}

struct Settings_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
