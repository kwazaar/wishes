//
//  ContentView.swift
//  wishes
//
//  Created by MaxOS on 11.12.2023.
//

import SwiftUI

struct WishesView: View {
    
    @ObservedObject var viewModel = WishesViewModel()
    @State var isShowButton = false
    @State var timeToPushNotifications = Date()
    var body: some View {
        
        VStack {
            Text(viewModel.wish)
                .font(.title)
            Spacer()
            Text("Настройки")
                .font(.headline)
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
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        WishesView()
    }
}
