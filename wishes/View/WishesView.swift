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
    @State var isShowAlert = false
    
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
                        isShowAlert = true
                    } label: {
                        Label("О приложении", systemImage: "book")
                    }
                } label: {
                    Label("", systemImage: "ellipsis.circle")
                        .foregroundColor(.black)
                        .font(.title)
                }
                .frame(width: UIScreen.main.bounds.width - 20, alignment: .trailing)
                Spacer()
                Text(viewModel.wish)
                    .font(.title)
                    .multilineTextAlignment(.center)
                Spacer()
//                Button("Test button") {
//                    viewModel.testFunc()
//                }
//                .padding()
//                .background(.gray)
//                .cornerRadius(20)
//                .foregroundColor(.white)
            }
            .alert("Версия v1.0", isPresented: $isShowAlert, actions: {
                Button("Ок", role: .cancel) { }
            })
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
