//
//  MapViewController.swift
//  Seven_Winds_Studio
//
//  Created by Владимир Кацап on 02.11.2024.
//

import UIKit

protocol MapViewDelegate: AnyObject {
    func pointTapped(cafeID: Int)
}


class MapViewController: UIViewController, MapViewDelegate {
    
    let cafes: [Cafe]
    
    private lazy var mainView = MapView(cafe: cafes)
    
    init(cafes: [Cafe]) {
        self.cafes = cafes
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.title = "Карта"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mainView.delegate = self
        self.view = mainView
        setupCustomBackButton()
    }
    
    private func setupCustomBackButton() {
        let backImage = UIImage(resource: .backNavBut).resize(targetSize: CGSize(width: 24, height: 24)) // Замените на имя вашего изображения
        let backButton = UIBarButtonItem(image: backImage.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(backButtonTapped))
        
        navigationItem.leftBarButtonItem = backButton
        navigationItem.hidesBackButton = true
    }
    
    @objc private func backButtonTapped() {
        navigationController?.popViewController(animated: true)
    }
    
    func pointTapped(cafeID: Int) {
        let vc = DetailCafeViewController(id: cafeID)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
}
