//
//  MenuCollectionViewCell.swift
//  Seven_Winds_Studio
//
//  Created by Владимир Кацап on 03.11.2024.
//

import UIKit

class MenuCollectionViewCell: UICollectionViewCell {
    
    weak var delegate: DetailCafeViewControllerDelegate?
    
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 5
        return imageView
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.textColor = .subTextBrown
        label.font = .systemFont(ofSize: 15, weight: .regular)
        return label
    }()
    
    private lazy var priceLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.textColor = .figmaBrown
        label.font = .systemFont(ofSize: 14, weight: .bold)
        return label
    }()
    
    private lazy var minusButton: UIButton = {
        let button = UIButton(type: .system)
        button.setBackgroundImage(.minus, for: .normal)
        return button
    }()
    
    private lazy var plusButton: UIButton = {
        let button = UIButton(type: .system)
        button.setBackgroundImage(.plus, for: .normal)
        return button
    }()
    
    private lazy var countLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.textColor = .figmaBrown
        label.font = .systemFont(ofSize: 14, weight: .light)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setupUI()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        backgroundColor = .white
        self.layer.cornerRadius = 5
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOpacity = 0.15
        self.layer.shadowOffset = CGSize(width: 0, height: 3)
        self.layer.shadowRadius = 1
        self.layer.masksToBounds = false
        self.layer.borderColor = UIColor.black.withAlphaComponent(0.25).cgColor
        self.layer.borderWidth = 0.25
        
        addSubview(imageView)
        imageView.snp.makeConstraints { make in
            make.left.right.top.equalToSuperview()
            make.height.equalTo(137)
        }
        
        addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(15)
            make.top.equalTo(imageView.snp.bottom).inset(-8)
        }
        
        addSubview(priceLabel)
        priceLabel.snp.makeConstraints { make in
            make.left.bottom.equalToSuperview().inset(15)
        }
        
        addSubview(plusButton)
        plusButton.snp.makeConstraints { make in
            make.right.equalToSuperview().inset(15)
            make.height.width.equalTo(24)
            make.centerY.equalTo(priceLabel)
        }
        
        addSubview(countLabel)
        countLabel.snp.makeConstraints { make in
            make.centerY.equalTo(priceLabel)
            make.right.equalTo(plusButton.snp.left).inset(-4)
        }
        
        addSubview(minusButton)
        minusButton.snp.makeConstraints { make in
            make.height.width.equalTo(24)
            make.centerY.equalTo(priceLabel)
            make.right.equalTo(countLabel.snp.left).inset(-4)
        }
    }
    
    @objc private func minusTapped(sender: UIButton) {
        delegate?.minusTapped(idCofe: sender.tag)
    }
    
    @objc private func plusTapped(sender: UIButton) {
        delegate?.plusTapped(idCofe: sender.tag)
    }
    
    func addElemnt(image: UIImage, name: String, price: String, count: Int, indexPath: Int, delegate: DetailCafeViewControllerDelegate) {
        self.delegate = delegate
        plusButton.tag = indexPath
        minusButton.tag = indexPath
        imageView.image = image
        titleLabel.text = name
        priceLabel.text = price
        countLabel.text = "\(count)"
        plusButton.addTarget(self, action: #selector(plusTapped(sender:)), for: .touchUpInside)
        minusButton.addTarget(self, action: #selector(minusTapped(sender:)), for: .touchUpInside)
    }
}
