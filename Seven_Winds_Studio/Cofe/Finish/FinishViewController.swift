//
//  FinishViewController.swift
//  Seven_Winds_Studio
//
//  Created by Владимир Кацап on 03.11.2024.
//

import UIKit

protocol FinishViewControllerDelegate: AnyObject {
    func returnSortedMenu(isReloadCollection: Bool) -> [Menu]
    func minusCofe(id: Int)
    func plusCofe(id: Int)
}

class FinishViewController: UIViewController {

    weak var delegate: DetailCafeViewControllerDelegate?
    var arrMenu: [Menu]
    
    private let mainView = FinishView()
    
    init(delegate: DetailCafeViewControllerDelegate?, arrMenu: [Menu]) {
        self.delegate = delegate
        self.arrMenu = arrMenu
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        delegate?.getArr(arr: arrMenu)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.title = "Ваш заказ"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCustomBackButton()
        self.view = mainView
        mainView.delegate = self
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
    

    private func reloadCollection() {
        mainView.updateCollection()
    }

}

extension FinishViewController: FinishViewControllerDelegate {
    
    func returnSortedMenu(isReloadCollection: Bool) -> [Menu] {
        var arr: [Menu] = []
        
        for i in arrMenu {
            if i.count ?? 0 > 0 {
                arr.append(i)
            }
        }
        if isReloadCollection {
            reloadCollection()
        }
        
        if arr.isEmpty  {
            self.navigationController?.popViewController(animated: true)
        }
        
        return arr
    }
    
    func minusCofe(id: Int) {
        let index: Int = arrMenu.firstIndex(where: {$0.id == id}) ?? 0
        if arrMenu[index].count ?? 0 > 0 {
            arrMenu[index].count! -= 1
        }
        reloadCollection()
    }
    
    func plusCofe(id: Int) {
        let index: Int = arrMenu.firstIndex(where: {$0.id == id}) ?? 0
        arrMenu[index].count! += 1
        reloadCollection()
    }
  
}
