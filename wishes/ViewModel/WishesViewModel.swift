//
//  WishesViewModel.swift
//  wishes
//
//  Created by MaxOS on 11.12.2023.
//

import Foundation
import Alamofire


class WishesViewModel : ObservableObject {
    
    @Published var valueWish: String = ""
    @Published var date: Int = 0
    
    func fetchWishes () {

        guard let url = URL(string: "https://hqhzpodbhmedtadbwsvn.supabase.co/rest/v1/wishes?select=*") else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"

        let headers: HTTPHeaders = ["apikey" : "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImhxaHpwb2RiaG1lZHRhZGJ3c3ZuIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MDIwNjI3MzcsImV4cCI6MjAxNzYzODczN30.Nwnnxx2xgO_yuLhwG-Ld2yIUhwIfi01hmS4m3hUD0Yg", "Authorization": "Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImhxaHpwb2RiaG1lZHRhZGJ3c3ZuIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MDIwNjI3MzcsImV4cCI6MjAxNzYzODczN30.Nwnnxx2xgO_yuLhwG-Ld2yIUhwIfi01hmS4m3hUD0Yg"]
        
        AF.request(url, method: .get, headers: headers)
            .validate()
            .responseDecodable(of: [Wish].self) { response in
                switch response.result {
                case .success(let decodedWishes):
                    DispatchQueue.main.async {
                        self.valueWish = decodedWishes[Int.random(in: 0...10)].value
                    }
                case .failure(let error):
                    print("Error: \(error)")
                }
            }
    }
}
