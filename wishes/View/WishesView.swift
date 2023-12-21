//
//  ContentView.swift
//  wishes
//
//  Created by MaxOS on 11.12.2023.
//

import SwiftUI

struct WishesView: View {
    
    @ObservedObject var viewModel = WishesViewModel()
    @State var isShowSettings = false
    
    var body: some View {
        
        NavigationStack {
            VStack {
                Menu {
                    Button {
                        isShowSettings = true
                    } label: {
                        Label("Настройки", systemImage: "wrench.and.screwdriver")
                    }
                    Button {
                        print("Тест")
                    } label: {
                        Label("О приложении", systemImage: "book")
                    }
                } label: {
                    Label("", systemImage: "ellipsis.circle")
                        .foregroundColor(.black)
                        .font(.title)
                }
                .frame(width: UIScreen.main.bounds.width , alignment: .trailing)
                Spacer()
                Text(viewModel.wish)
                    .font(.title)
                Spacer()
//                Button("Test button") {
//                    viewModel.testFunc()
//                }
//                .padding()
//                .background(.gray)
//                .cornerRadius(20)
//                .foregroundColor(.white)
            }
            .navigationDestination(isPresented: $isShowSettings) {
                SettingsView()
                    .navigationTitle("Настройки")
                    .navigationBarBackButtonHidden()
            }
            .padding()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        WishesView()
    }
}
