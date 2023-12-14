//
//  Model.swift
//  wishes
//
//  Created by MaxOS on 11.12.2023.
//

import Foundation


struct Wish : Codable {
    
    let id: Int
    let created_at: String
    let value: String
    
}
