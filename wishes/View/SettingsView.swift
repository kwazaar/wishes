//
//  Settings.swift
//  wishes
//
//  Created by MaxOS on 19.12.2023.
//

import SwiftUI

struct SettingsView: View {
    
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var viewModel = WishesViewModel()
    @State var editSettings = true
    
    var body: some View {
        
        NavigationView {
            List {
                Toggle("Включить уведомления", isOn: $viewModel.isOnSwitchNotification)
                    .onChange(of: viewModel.isOnSwitchNotification) { _ in
                            editSettings = false
                    }
                
                    DatePicker("Время уведомления", selection: Binding<Date>(get: {
                        viewModel.selectDate
                    }, set: { newValue in
                        if viewModel.timeToPushNotifications != newValue.timeIntervalSince1970 {
                            editSettings = false
                            viewModel.selectDate = newValue
                            viewModel.timeToPushNotifications = newValue.timeIntervalSince1970
                        }
                        
                        
                        
                    }) , displayedComponents: .hourAndMinute)
                    .disabled(!viewModel.isOnSwitchNotification)
                
                
            }
        } .navigationBarItems(trailing:
                                Button("Сохранить", action: {
            if !editSettings {
                viewModel.setNotification()
            }
            editSettings = true
        })  .disabled(editSettings)
            .bold()
            .foregroundColor(editSettings ? .gray : .black))
        .navigationBarItems(leading:
                            Button(action: {
            self.presentationMode.wrappedValue.dismiss()
        }, label: {
            Image(systemName: "chevron.left")
            Text("Пожелания")
        })
                                .foregroundColor(.black)
                                .bold()
        )
        
        
        
    }
}

struct Settings_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
