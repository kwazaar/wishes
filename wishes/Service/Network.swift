//
//  Network.swift
//  wishes
//
//  Created by MaxOS on 14.12.2023.
//

import Foundation
import Alamofire

class NetworkService {
    
    static let shared = NetworkService()
    
    private init() {}
    
    let headers: HTTPHeaders = ["apikey" : "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImhxaHpwb2RiaG1lZHRhZGJ3c3ZuIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MDIwNjI3MzcsImV4cCI6MjAxNzYzODczN30.Nwnnxx2xgO_yuLhwG-Ld2yIUhwIfi01hmS4m3hUD0Yg", "Authorization": "Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImhxaHpwb2RiaG1lZHRhZGJ3c3ZuIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MDIwNjI3MzcsImV4cCI6MjAxNzYzODczN30.Nwnnxx2xgO_yuLhwG-Ld2yIUhwIfi01hmS4m3hUD0Yg"]
    
    func fetchWishes(completion: @escaping (Result<[Wish], Error>) -> ()) {

        guard let url = URL(string: "https://hqhzpodbhmedtadbwsvn.supabase.co/rest/v1/wishes?select=*") else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        AF.request(url, method: .get, headers: headers)
            .validate()
            .responseDecodable(of: [Wish].self) { response in
                switch response.result {
                case .success(let decodedWishes):
                    completion(.success(decodedWishes))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
    }
    
    
}
