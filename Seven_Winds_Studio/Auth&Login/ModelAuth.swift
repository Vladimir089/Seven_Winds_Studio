//
//  ModelAuth.swift
//  Seven_Winds_Studio
//
//  Created by Владимир Кацап on 02.11.2024.
//

import Foundation


struct Auth: Codable {
    let token: String
    let tokenLifetime: Int
}

