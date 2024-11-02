//
//  MapView.swift
//  Seven_Winds_Studio
//
//  Created by Владимир Кацап on 02.11.2024.
//

import UIKit
import YandexMapsMobile

class MapView: UIView, YMKMapObjectTapListener {
    
    
    let cafe: [Cafe]
    weak var delegate: MapViewDelegate?
    
    private lazy var map = YMKMapView.init(frame: .zero, vulkanPreferred: StaticClass.isM1Simulator())
    
    init(cafe: [Cafe]) {
        self.cafe = cafe
        super.init(frame: .zero)
        setupUI()
        addCafesToMap()
    }
    
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        self.backgroundColor = .white
        self.addSubview(map!)
        map?.snp.makeConstraints({ make in
            make.left.right.bottom.equalToSuperview()
            make.top.equalTo(self.safeAreaLayoutGuide.snp.top)
        })
    }
    
    private func addCafesToMap() {
        let mapObjects = map!.mapWindow.map.mapObjects
        
        for cafe in cafe {
            if let latitude = Double(cafe.point.latitude),
               let longitude = Double(cafe.point.longitude) {
                let point = YMKPoint(latitude: latitude, longitude: longitude)
                
                let placemark = mapObjects.addPlacemark(with: point)
                placemark.setIconWith(UIImage(resource: .pin) )
                placemark.setTextWithText(cafe.name)
                placemark.setTextStyleWith(.init(size: 14, color: .figmaBrown, outlineWidth: 0, outlineColor: nil, placement: .bottom, offset: 0, offsetFromIcon: true, textOptional: false))
                placemark.userData = cafe
                placemark.addTapListener(with: self)
            }
        }
    }
    
    func onMapObjectTap(with mapObject: YMKMapObject, point: YMKPoint) -> Bool {
        
        if let cafe = mapObject.userData as? Cafe {
            delegate?.pointTapped(cafeID: cafe.id)
        } else {
            print("Tapped object is not a cafe")
        }
        
        return true
    }
    
}
