//
//  ModelDetail.swift
//  Seven_Winds_Studio
//
//  Created by Владимир Кацап on 02.11.2024.
//

import Foundation

struct Menu: Codable {
    let id: Int
    let name: String
    let imageURL: String
    let price: Int
    var image: Data?
    var count: Int? 
}

