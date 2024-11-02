//
//  DataFlowDetailCafe.swift
//  Seven_Winds_Studio
//
//  Created by Владимир Кацап on 02.11.2024.
//

import Foundation
import Alamofire

class DataFlowDetailCafe {
    
    func loadCafeData(token: String, id: Int, escaping: @escaping(Bool, [Menu]?) -> Void) {
        let bearer: HTTPHeaders = [.authorization(bearerToken: token)]
        
        let url = "http://147.78.66.203:3210/location/\(id)/menu"
        
        AF.request(url, headers: bearer).responseData { response in
            switch response.result {
            case .success(let data):
                do {
                    let menu = try JSONDecoder().decode([Menu].self, from: data)
                    self.loadImagesAndConvertToData(menu: menu) { newMenu in
                        escaping(true, newMenu)
                    }
                } catch {
                    print("Ошибка декодирования: \(error.localizedDescription)")
                    escaping(false, nil)
                }
            case .failure(_):
                escaping(false, nil)
            }
        }
    }
    
    private func loadImagesAndConvertToData(menu: [Menu], escaping: @escaping ([Menu]) -> Void) {
        var updatedMenu = menu
        let group = DispatchGroup()

        for (index, item) in updatedMenu.enumerated() {
            group.enter()
            guard let url = URL(string: item.imageURL) else {
                group.leave()
                continue
            }
            URLSession.shared.dataTask(with: url) { data, response, error in
                defer { group.leave() }

                if let error = error {
                    return
                }
                
                guard let data = data else {
                    return
                }
                updatedMenu[index].image = data
                updatedMenu[index].count = 0
            }.resume()
        }
        group.notify(queue: .main) {
            escaping(updatedMenu)
        }
    }

}
