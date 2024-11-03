//
//  MainCofeViewController.swift
//  Seven_Winds_Studio
//
//  Created by Владимир Кацап on 02.11.2024.
//

import UIKit
import CoreLocation

protocol MainCofeViewControllerDelegate: AnyObject {
    func cellTapped(id: Int)
    //func calculateDistances
}

class MainCofeViewController: UIViewController {
    
    private lazy var mainView = CoffeView()
    private let token: String = UserDefaults.standard.string(forKey: "token") ?? ""
    
    private let dataFlow = CafeDataFlow()
    private let locationFlow = LocationFlow()
    
    private lazy var cafes: [Cafe] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view = mainView
        mainView.delegate = self
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
        locationFlow.calculateDistances(for: arr) { updatedCafes in
            self.mainView.loadCollection(arr: updatedCafes)
            self.cafes = updatedCafes
        }
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


extension MainCofeViewController: MainCofeViewControllerDelegate {
    
    func cellTapped(id: Int) {
        let vc = DetailCafeViewController(id: id)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
}
