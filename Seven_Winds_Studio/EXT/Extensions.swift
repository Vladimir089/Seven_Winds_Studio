//
//  Extensions.swift
//  Seven_Winds_Studio
//
//  Created by Владимир Кацап on 02.11.2024.
//

import Foundation
import UIKit

extension UINavigationController {
    
    open override func viewDidLoad() {
        super.viewDidLoad()
        
        let titleColor = UIColor.figmaBrown
        let titleFont = UIFont.systemFont(ofSize: 18, weight: .bold)
        
        navigationBar.titleTextAttributes = [
            .foregroundColor: titleColor,
            .font: titleFont
        ]
        navigationBar.barTintColor = #colorLiteral(red: 0.9803921569, green: 0.9764705882, blue: 0.9764705882, alpha: 1)
        
        navigationBar.shadowImage = UIImage() //для удаления тени
        
        var yCoord = navigationBar.frame.height
        
        for _ in 0..<2 {
            let navBarUnderline = UIView(frame: CGRect(x: 0, y: yCoord, width: navigationBar.frame.width, height: 0.5))
            navBarUnderline.backgroundColor = #colorLiteral(red: 0.7607843137, green: 0.7607843137, blue: 0.7607843137, alpha: 1)
            navBarUnderline.autoresizingMask = .flexibleWidth
            navigationBar.addSubview(navBarUnderline)
            yCoord -= 2
        }
        
    }
}


extension UIImage {
    func resize(targetSize: CGSize) -> UIImage {
        let size = self.size
        let widthRatio  = targetSize.width  / size.width
        let heightRatio = targetSize.height / size.height
        let newSize: CGSize
        if widthRatio > heightRatio {
            newSize = CGSize(width: size.width * heightRatio, height: size.height * heightRatio)
        } else {
            newSize = CGSize(width: size.width * widthRatio,  height: size.height * widthRatio)
        }
        UIGraphicsBeginImageContextWithOptions(newSize, false, UIScreen.main.scale)
        self.draw(in: CGRect(origin: .zero, size: newSize))
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage!
    }
}



