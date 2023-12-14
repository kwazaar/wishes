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
    var body: some View {
        
        VStack {
            
            Text(viewModel.valueWish)
            if !isShowButton {
                Button("Get your wishes") {
                    viewModel.fetchWishes()
                    isShowButton.toggle()
                }
            }
        }
        .padding()
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        WishesView()
    }
}
