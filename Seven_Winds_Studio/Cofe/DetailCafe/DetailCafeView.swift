//
//  DetailCafeView.swift
//  Seven_Winds_Studio
//
//  Created by Владимир Кацап on 02.11.2024.
//

import UIKit

class DetailCafeView: UIView {

    weak var delegate: DetailCafeViewControllerDelegate?
    var id: Int
    private var arrMenu: [Menu] = []
    
    private lazy var collection: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.backgroundColor = .clear
        collection.showsVerticalScrollIndicator = false
        layout.scrollDirection = .vertical
        collection.contentInset = UIEdgeInsets(top: 10, left: 0, bottom: 70, right: 0)
        collection.register(MenuCollectionViewCell.self, forCellWithReuseIdentifier: "1")
        collection.delegate = self
        collection.dataSource = self
        layout.minimumInteritemSpacing = 10
        layout.minimumLineSpacing = 20
        return collection
    }()
    
    private let loadIndicator: UIActivityIndicatorView = {
        let view = UIActivityIndicatorView(style: .large)
        view.color = .figmaBrown
        return view
    }()
    
    private lazy var nextButton = StaticClass.createBrownButton(title: "Перейти к оплате")
    
    init(id: Int) {
        self.id = id
        super.init(frame: .zero)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        self.backgroundColor = .white
        
        collection.alpha = 0
        addSubview(collection)
        collection.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(15)
            make.top.equalTo(self.safeAreaLayoutGuide.snp.top)
            make.bottom.equalToSuperview()
        }

        addSubview(loadIndicator)
        loadIndicator.snp.makeConstraints { make in
            make.height.width.equalTo(120)
            make.center.equalToSuperview()
        }
        loadIndicator.startAnimating()
        
        addSubview(nextButton)
        nextButton.alpha = 0
        nextButton.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(15)
            make.bottom.equalTo(self.safeAreaLayoutGuide.snp.bottom).inset(10)
            make.height.equalTo(47)
        }
        nextButton.addTarget(self, action: #selector(goNext), for: .touchUpInside)
    }
    
    
    func dataLoaded(menu: [Menu]) {
        UIView.animate(withDuration: 0.3) {
            self.loadIndicator.alpha = 0
            self.collection.alpha = 1
        }
        self.arrMenu = menu
        collection.reloadData()
    }
    
    func updateCollection(newMenu: [Menu], updateItem: Int) {
        self.arrMenu = newMenu
        collection.reloadItems(at: [IndexPath(row: updateItem, section: 0)])
    }
    
    func updateAllCells(arr: [Menu]) {
        self.arrMenu = arr
        collection.reloadData()
    }
    
    func showNextButton(isShow: Bool) {
        UIView.animate(withDuration: 0.3) {
            self.nextButton.alpha = isShow ? 1 : 0
        }
    }
    
    @objc private func goNext() {
        delegate?.goFinish()
    }
    
}


extension DetailCafeView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrMenu.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "1", for: indexPath) as! MenuCollectionViewCell
        let item = arrMenu[indexPath.row]
        cell.addElemnt(image: UIImage(data: item.image ?? Data()) ?? UIImage(), name: item.name, price: "\(item.price) руб", count: item.count ?? 0, indexPath: indexPath.row, delegate: delegate!)
        print(indexPath.row)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 165, height: 205)
    }
    
}



