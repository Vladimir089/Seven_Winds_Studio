//
//  FinishCollectionViewCell.swift
//  Seven_Winds_Studio
//
//  Created by Владимир Кацап on 03.11.2024.
//

import UIKit

class FinishCollectionViewCell: UICollectionViewCell {
    
    weak var delegate: FinishViewControllerDelegate?
    
    private let nameCofeLabel: UILabel = {
        let label = UILabel()
        label.textColor = .figmaBrown
        label.font = .systemFont(ofSize: 18, weight: .bold)
        label.textAlignment = .left
        return label
    }()
    
    private let priceLabel: UILabel = {
        let label = UILabel()
        label.textColor = .subTextBrown
        label.font = .systemFont(ofSize: 16, weight: .light)
        label.textAlignment = .left
        return label
    }()
    
    private let countLabel: UILabel = {
        let label = UILabel()
        label.textColor = .figmaBrown
        label.font = .systemFont(ofSize: 16, weight: .semibold)
        label.textAlignment = .center
        return label
    }()
    
    private let minusButton: UIButton = {
        let button = UIButton(type: .system)
        button.setBackgroundImage(.minus.withRenderingMode(.alwaysTemplate), for: .normal)
        button.tintColor = .figmaBrown
        return button
    }()
    
    private let plusButton: UIButton = {
        let button = UIButton(type: .system)
        button.setBackgroundImage(.plus.withRenderingMode(.alwaysTemplate), for: .normal)
        button.tintColor = .figmaBrown
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        self.backgroundColor = #colorLiteral(red: 0.9827771783, green: 0.9175236821, blue: 0.8534319997, alpha: 1)
        self.layer.cornerRadius = 5
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOpacity = 0.25
        self.layer.shadowOffset = CGSize(width: 0, height: 3)
        self.layer.shadowRadius = 3
        self.layer.masksToBounds = false
        
        addSubview(nameCofeLabel)
        nameCofeLabel.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(15)
            make.top.equalToSuperview().inset(10)
        }
        
        addSubview(priceLabel)
        priceLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().inset(15)
            make.bottom.equalToSuperview().inset(10)
        }
        
        addSubview(plusButton)
        plusButton.snp.makeConstraints { make in
            make.height.width.equalTo(24)
            make.centerY.equalToSuperview()
            make.right.equalToSuperview().inset(15)
        }
        plusButton.addTarget(self, action: #selector(plus(sender:)), for: .touchUpInside)
        
        addSubview(countLabel)
        countLabel.snp.makeConstraints { make in
            make.right.equalTo(plusButton.snp.left).inset(-10)
            make.centerY.equalToSuperview()
        }
        
        addSubview(minusButton)
        minusButton.snp.makeConstraints { make in
            make.height.width.equalTo(25)
            make.centerY.equalToSuperview()
            make.right.equalTo(countLabel.snp.left).inset(-10)
        }
        minusButton.addTarget(self, action: #selector(minus(sender:)), for: .touchUpInside)
    }
    
    @objc private func plus(sender: UIButton) {
        delegate?.plusCofe(id: sender.tag)
    }
    
    @objc private func minus(sender: UIButton) {
        delegate?.minusCofe(id: sender.tag)
    }
    

    func loadData(name: String, price: String, count: Int, id: Int) {
        self.countLabel.text = "\(count)"
        self.nameCofeLabel.text = name
        self.priceLabel.text = price
        self.minusButton.tag = id
        self.plusButton.tag = id
    }
    
}

