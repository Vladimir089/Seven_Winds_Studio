//
//  DetailCafeViewController.swift
//  Seven_Winds_Studio
//
//  Created by Владимир Кацап on 02.11.2024.
//

import UIKit

protocol DetailCafeViewControllerDelegate: AnyObject {
    func minusTapped(idCofe: Int)
    func plusTapped(idCofe: Int)
    func goFinish()
}

class DetailCafeViewController: UIViewController {
    
    let id: Int
    private lazy var mainView = DetailCafeView(id: id)
    private let token: String = UserDefaults.standard.string(forKey: "token") ?? ""
    private let dataFlow = DataFlowDetailCafe()
    private var arrMenu: [Menu] = []
    
    init(id: Int) {
        self.id = id
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.title = "Меню"
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view = mainView
        mainView.delegate = self
        setupCustomBackButton()
        loadData()
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
    
    private func loadData() {
        dataFlow.loadCafeData(token: token, id: id) { result, menu in
            if result {
                self.arrMenu = menu ?? []
                self.mainView.dataLoaded(menu: self.arrMenu)
            }
        }
    }
    
    private func updateCoollection(id: Int) {
        mainView.updateCollection(newMenu: arrMenu, updateItem: id)
        if arrMenu.contains(where: {$0.count ?? 0 > 0}) {
            mainView.showNextButton(isShow: true)
        } else {
            mainView.showNextButton(isShow: false)
        }
    }

}

extension DetailCafeViewController: DetailCafeViewControllerDelegate {
    func minusTapped(idCofe: Int) {
        if arrMenu[idCofe].count ?? 0 > 0 {
            arrMenu[idCofe].count! -= 1
        }
        updateCoollection(id: idCofe)
    }
    
    func plusTapped(idCofe: Int) {
        arrMenu[idCofe].count! += 1
        updateCoollection(id: idCofe)
    }
    
    func goFinish() {
        let vc = FinishViewController(delegate: self, arrMenu: arrMenu)
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
