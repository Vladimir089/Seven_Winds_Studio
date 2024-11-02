//
//  AuthDataFlow.swift
//  Seven_Winds_Studio
//
//  Created by Владимир Кацап on 02.11.2024.
//

import Foundation
import Alamofire

class AuthDataFlow {
    
    func registerUser(login: String, password: String, isReg: Bool, escaping: @escaping(_ result: Bool, Auth?) -> Void) {
        
        let parameters: [String: String] = [
            "login": login,
            "password": password
        ]
        
        
        let urlString = "http://147.78.66.203:3210/auth/\(isReg ? "register" : "login")"
        
        guard let url = URL(string: urlString) else {
            escaping(false, nil)
            return
        }
        
        let headers: HTTPHeaders = [
            "Content-Type": "application/json",
            "Accept": "application/json"
        ]
        
        AF.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: headers)
            .validate()
            .responseData{ response in
                switch response.result {
                case .success(let data):
                    do {
                        let auth = try JSONDecoder().decode(Auth.self, from: data)
                        escaping(true, auth)
                    } catch {
                        print("Ошибка декодирования: \(error.localizedDescription)")
                        escaping(false, nil)
                    }
                case .failure(let error):
                    escaping(false, nil)
                }
            }
    }
    
}
