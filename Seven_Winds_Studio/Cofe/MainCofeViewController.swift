//
//  MainCofeViewController.swift
//  Seven_Winds_Studio
//
//  Created by Владимир Кацап on 02.11.2024.
//

import UIKit
import Combine
import CoreLocation

class MainCofeViewController: UIViewController {
    
    private lazy var mainView = CoffeView()
    private let token: String = UserDefaults.standard.string(forKey: "token") ?? ""
    
    private let dataFlow = CafeDataFlow()
    private let locationFlow = LocationFlow()
    
    private lazy var cancellable = [AnyCancellable]()
    private lazy var cafes: [Cafe] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view = mainView
        settingsNav()
        downloadData()
        addTarget()
    }
    
    private func settingsNav() {
        self.title = "Ближайшие кофейни"
    }
    
    private func downloadData() {
        dataFlow.loadCafeData(token: token) { result, cafes in
            if result == false {
                UserDefaults.standard.removeObject(forKey: "token")
                self.navigationController?.setViewControllers([AuthViewController()], animated: true)
                return
            } else {
                self.location(arr: cafes ?? [])
            }
        }
        
        
    }
    
    private func location(arr: [Cafe]) {
        locationFlow.calculateDistances(for: arr)
            .sink(receiveValue: { updatedCafes in
                self.mainView.loadCollection(arr: updatedCafes)
                self.cafes = updatedCafes
            })
            .store(in: &cancellable)
    }
    
    private func addTarget() {
        let but = mainView.addTargetInButton()
        but.addTarget(self, action: #selector(openMapVC), for: .touchUpInside)
    }
    
    
    @objc private func openMapVC() {
        let vc = MapViewController(cafes: cafes)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}
