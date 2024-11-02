//
//  CoffeView.swift
//  Seven_Winds_Studio
//
//  Created by Владимир Кацап on 02.11.2024.
//

import UIKit

class CoffeView: UIView {
    
    private lazy var cafeArr: [Cafe] = []
    
    
    private lazy var collection: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.backgroundColor = .clear
        collection.showsVerticalScrollIndicator = false
        layout.scrollDirection = .vertical
        collection.register(CafeCollectionViewCell.self, forCellWithReuseIdentifier: "1")
        layout.minimumLineSpacing = 10
        collection.contentInset = UIEdgeInsets(top: 10, left: 0, bottom: 70, right: 0)
        collection.delegate = self
        collection.dataSource = self
        return collection
    }()
    
    private lazy var progressView: UIActivityIndicatorView = {
        let view = UIActivityIndicatorView(style: .large)
        view.color = .figmaBrown
        return view
    }()
    
    private lazy var showMapButton = StaticClass.createBrownButton(title: "На карте")

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        self.backgroundColor = .white
        addSubview(collection)
        collection.alpha = 0
        collection.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(15)
            make.bottom.equalToSuperview()
            make.top.equalTo(safeAreaLayoutGuide.snp.top)
        }
        
        addSubview(progressView)
        progressView.snp.makeConstraints { make in
            make.height.width.equalTo(120)
            make.center.equalToSuperview()
        }
        progressView.startAnimating()
        
        addSubview(showMapButton)
        showMapButton.alpha = 0
        showMapButton.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(15)
            make.bottom.equalTo(safeAreaLayoutGuide.snp.bottom).inset(10)
            make.height.equalTo(47)
        }
    }
    
    func loadCollection(arr: [Cafe]) {
        self.cafeArr = arr
        collection.reloadData()
        UIView.animate(withDuration: 0.3) {
            self.collection.alpha = 1
            self.progressView.alpha = 0
            self.showMapButton.alpha = 1
        }
        progressView.stopAnimating()
    }
    
    func addTargetInButton() -> UIButton {
        return showMapButton
    }
    
}


extension CoffeView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cafeArr.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "1", for: indexPath) as! CafeCollectionViewCell
        cell.updateLabels(name: cafeArr[indexPath.row].name, distance: cafeArr[indexPath.row].distance ?? "0 км от вас")
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.width, height: 68)
    }
    
}
