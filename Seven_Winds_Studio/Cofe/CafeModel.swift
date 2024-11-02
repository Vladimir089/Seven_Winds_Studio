//
//  CafeModel.swift
//  Seven_Winds_Studio
//
//  Created by Владимир Кацап on 02.11.2024.
//

import Foundation


struct Cafe: Codable {
    let id: Int
    let name: String
    let point: Point
    var distance: String?
}

struct Point: Codable {
    let latitude, longitude: String
}
