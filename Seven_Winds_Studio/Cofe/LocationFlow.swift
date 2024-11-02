//
//  LocationFlow.swift
//  Seven_Winds_Studio
//
//  Created by Владимир Кацап on 02.11.2024.
//

import Foundation
import CoreLocation
import Combine

class LocationFlow: NSObject, CLLocationManagerDelegate {
    
    private let locationManager = CLLocationManager()
    private var latitude: CLLocationDegrees?
    private var longitude: CLLocationDegrees?
    
    let locationSubject = PassthroughSubject<[Double], Never>()
    private var hasSentCoordinates = false
    
    override init() {
        super.init()
        locationManager.delegate = self
        requestLocationAuthorization()
    }
    
    private func requestLocationAuthorization() {
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
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
    
    func calculateDistances(for cafes: [Cafe]) -> AnyPublisher<[Cafe], Never> {
        return locationSubject
            .first() // Получаем только первое значение
            .map { coordinates in
                let userLocation = CLLocation(latitude: coordinates[0], longitude: coordinates[1])
                var updatedCafes = cafes
                
                for (index, cafe) in cafes.enumerated() {
                    if let latitude = Double(cafe.point.latitude),
                       let longitude = Double(cafe.point.longitude) {
                        let cafeLocation = CLLocation(latitude: latitude, longitude: longitude)
                        let distanceInMeters = userLocation.distance(from: cafeLocation)
                        let distanceInKilometers = distanceInMeters / 1000
                        updatedCafes[index].distance = String(format: "%.1f км от вас", distanceInKilometers)
                    }
                }
                
                return updatedCafes // Возвращаем обновленный массив кафе
            }
            .eraseToAnyPublisher()
    }

    
    
    // MARK: - CLLocationManagerDelegate
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        latitude = location.coordinate.latitude
        longitude = location.coordinate.longitude
        
        locationSubject.send([latitude ?? 0, longitude ?? 0])
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Ошибка получения местоположения: \(error.localizedDescription)")
    }
}
