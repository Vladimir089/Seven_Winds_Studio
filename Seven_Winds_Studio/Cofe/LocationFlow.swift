//
//  LocationFlow.swift
//  Seven_Winds_Studio
//
//  Created by Владимир Кацап on 02.11.2024.
//

import Foundation
import CoreLocation


class LocationFlow: NSObject, CLLocationManagerDelegate {
    
    private let locationManager = CLLocationManager()
    private var latitude: CLLocationDegrees?
    private var longitude: CLLocationDegrees?
    
    override init() {
        super.init()
        locationManager.delegate = self
        requestLocationAuthorization()
    }
    
    private func requestLocationAuthorization() {
        locationManager.requestWhenInUseAuthorization()
        startUpdatingLocation()
    }
    
    func startUpdatingLocation() {
        locationManager.startUpdatingLocation()
    }
    
    func stopUpdatingLocation() {
        locationManager.stopUpdatingLocation()
    }
    
    func getLocationUser() -> [Double] {
        return [latitude ?? 0, longitude ?? 0]
    }
    
    //ТУТ БЫЛ COMBINE
    func calculateDistances(for cafes: [Cafe], completion: @escaping ([Cafe]) -> Void) {

        let latitude = getLocationUser().first ?? 0
        let longitude = getLocationUser().last ?? 0
        
        let userLocation = CLLocation(latitude: latitude, longitude: longitude)
        var updatedCafes = cafes
        
        for (index, cafe) in cafes.enumerated() {
            if let cafeLatitude = Double(cafe.point.latitude),
               let cafeLongitude = Double(cafe.point.longitude) {
                let cafeLocation = CLLocation(latitude: cafeLatitude, longitude: cafeLongitude)
                let distanceInMeters = userLocation.distance(from: cafeLocation)
                let distanceInKilometers = distanceInMeters / 1000
                updatedCafes[index].distance = String(format: "%.1f км от вас", distanceInKilometers)
            }
        }
        completion(updatedCafes)
    }



    
    
    // MARK: - CLLocationManagerDelegate
    //ТУТ БЫЛ COMBINE
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        latitude = location.coordinate.latitude
        longitude = location.coordinate.longitude
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Ошибка получения местоположения: \(error.localizedDescription)")
    }
}
