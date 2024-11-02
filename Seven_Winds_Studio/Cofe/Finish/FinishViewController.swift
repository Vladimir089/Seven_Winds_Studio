//
//  FinishViewController.swift
//  Seven_Winds_Studio
//
//  Created by Владимир Кацап on 03.11.2024.
//

import UIKit

class FinishViewController: UIViewController {

    weak var delegate: DetailCafeViewControllerDelegate?
    var arrMenu: [Menu]
    
    private lazy var mainView = FinishView(arr: arrMenu)
    
    init(delegate: DetailCafeViewControllerDelegate?, arrMenu: [Menu]) {
        self.delegate = delegate
        self.arrMenu = arrMenu
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.title = "Ваш заказ"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCustomBackButton()
        self.view = mainView
        mainView.delegate = delegate
    }
    

    private func setupCustomBackButton() {
        
        let backImage = UIImage(resource: .backNavBut).resize(targetSize: CGSize(width: 24, height: 24))
        let backButton = UIBarButtonItem(image: backImage.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(backButtonTapped))
        
        navigationItem.leftBarButtonItem = backButton
        navigationItem.hidesBackButton = true
    }
    
    @objc private func backButtonTapped() {
        navigationController?.popViewController(animated: true)
    }

}



