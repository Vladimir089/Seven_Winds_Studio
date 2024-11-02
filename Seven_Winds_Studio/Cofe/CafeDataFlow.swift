//
//  CafeDataFlow.swift
//  Seven_Winds_Studio
//
//  Created by Владимир Кацап on 02.11.2024.
//

import Foundation
import Alamofire

class CafeDataFlow {
    
    func loadCafeData(token: String, escaping: @escaping(Bool, [Cafe]?) -> Void) {
        let bearer: HTTPHeaders = [.authorization(bearerToken: token)]
        
        let url = "http://147.78.66.203:3210/locations"
        
        AF.request(url, headers: bearer).responseData { response in
            switch response.result {
            case .success(let data):
                do {
                    let cafe = try JSONDecoder().decode([Cafe].self, from: data)
                    escaping(true, cafe)
                } catch {
                    print("Ошибка декодирования: \(error.localizedDescription)")
                    escaping(false, nil)
                }
            case .failure(_):
                escaping(false, nil)
            }
        } 
    }
    
}
