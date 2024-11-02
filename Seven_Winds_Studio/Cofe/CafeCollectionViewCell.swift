//
//  CafeCollectionViewCell.swift
//  Seven_Winds_Studio
//
//  Created by Владимир Кацап on 02.11.2024.
//

import UIKit

class CafeCollectionViewCell: UICollectionViewCell {
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .figmaBrown
        label.font = .systemFont(ofSize: 18, weight: .bold)
        label.textAlignment = .left
        return label
    }()
    
    private let distanceLabel = {
        let label = UILabel()
        label.textColor = .subTextBrown
        label.textAlignment = .left
        label.font = .systemFont(ofSize: 14, weight: .light)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        self.backgroundColor = .figmaLightBrown
        self.layer.cornerRadius = 5
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOpacity = 0.15
        self.layer.shadowOffset = CGSize(width: 0, height: 3)
        self.layer.shadowRadius = 1
        self.layer.masksToBounds = false
        
        addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(15)
            make.bottom.equalTo(self.snp.centerY).offset(3)
        }
        
        addSubview(distanceLabel)
        distanceLabel.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(15)
            make.top.equalTo(self.snp.centerY).offset(5)
        }
    }
    
    
    func updateLabels(name: String, distance: String) {
        titleLabel.text = name
        distanceLabel.text = distance
    }
    
    
}
