//
//  FinishView.swift
//  Seven_Winds_Studio
//
//  Created by Владимир Кацап on 03.11.2024.
//

import UIKit

class FinishView: UIView {
    
    var delegate: FinishViewControllerDelegate?
    
    private lazy var menuArr = delegate?.returnSortedMenu(isReloadCollection: false)
    private lazy var paymentButton = StaticClass.createBrownButton(title: "Оплатить")
    
    private lazy var collection: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.backgroundColor = .clear
        collection.showsVerticalScrollIndicator = false
        layout.scrollDirection = .vertical
        collection.contentInset = UIEdgeInsets(top: 10, left: 0, bottom: 70, right: 0)
        collection.register(FinishCollectionViewCell.self, forCellWithReuseIdentifier: "1")
        collection.delegate = self
        collection.dataSource = self
        layout.minimumInteritemSpacing = 10
        layout.minimumLineSpacing = 10
        return collection
    }()
    
    private let textLabel: UILabel = {
        let label = UILabel()
        label.text = "Время ожидания заказа\n15 минут!\nСпасибо, что выбрали нас!"
        label.textAlignment = .center
        label.textColor = .figmaBrown
        label.font = .systemFont(ofSize: 25, weight: .semibold)
        label.numberOfLines = 3
        label.alpha = 0
        return label
    }()
    
    
    init() {
        super.init(frame: .zero)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        self.backgroundColor = .white
        addSubview(collection)
        collection.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(15)
            make.bottom.equalToSuperview()
            make.top.equalTo(self.safeAreaLayoutGuide.snp.top)
        }
        
        addSubview(paymentButton)
        paymentButton.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(15)
            make.bottom.equalTo(self.safeAreaLayoutGuide.snp.bottom).inset(10)
            make.height.equalTo(47)
        }
        paymentButton.addTarget(self, action: #selector(showLabel), for: .touchUpInside)
        
        addSubview(textLabel)
        textLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(self.snp.centerY).offset(50)
        }
    }
    
    @objc private func showLabel() {
        UIView.animate(withDuration: 0.3) {
            self.textLabel.alpha = 1
            self.paymentButton.alpha = 0
        }
    }
    
    func updateCollection() {
        self.menuArr = delegate?.returnSortedMenu(isReloadCollection: false)
        collection.reloadData()
    }
    
}


extension FinishView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return menuArr?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "1", for: indexPath) as! FinishCollectionViewCell
        
        let item = menuArr?[indexPath.row]
        cell.delegate = delegate
        cell.loadData(name: item?.name ?? "Name", price: "\(item?.price ?? 1 * (item?.count ?? 1)) руб" , count: item?.count ?? 1, id: item?.id ?? 0)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.width, height: 68)
    }
    
}
