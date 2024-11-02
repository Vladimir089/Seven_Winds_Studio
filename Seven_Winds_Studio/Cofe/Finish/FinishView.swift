//
//  FinishView.swift
//  Seven_Winds_Studio
//
//  Created by Владимир Кацап on 03.11.2024.
//

import UIKit

class FinishView: UIView {
    
    private var arr: [Menu]
    var delegate: DetailCafeViewControllerDelegate?
    
    init(arr: [Menu]) {
        self.arr = arr
        super.init(frame: .zero)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        self.backgroundColor = .white
    }
    
}
