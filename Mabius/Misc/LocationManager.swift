//
//  LocationManager.swift
//
//  Created by Timafei Harhun on 27.01.17.
//  Copyright © 2017 Timafei Harhun. All rights reserved.
//

import CoreLocation
import Foundation

//MARK: - Coordinate

protocol Coordinate2D {
    var latitude: Double { get }
    var longitude: Double { get }
}

struct Coordinate: Coordinate2D {
    var latitude: Double
    var longitude: Double
}

//MARK: - Location Manager

enum LocationManagerError: Swift.Error {
    case locationNotAvailable
    case locationServicesDisabled
    case underlyingServiceError
}

protocol LocationManagerDelegate : class {
    func locationManager(_ mgr: LocationManager, didUpdate location: Coordinate2D)
    func locationManager(_ mgr: LocationManager, didFail reason: LocationManagerError)
    func locationManagerDidAllowPermission(_ mgr: LocationManager)
}

protocol LocationManager {
    
    init(delegate: LocationManagerDelegate?)
    var delegate: LocationManagerDelegate? { get set }
    
    func getLocationOneShot()
}

//MARK: - Location Manager Impl

class LocationManagerImpl: NSObject, LocationManager, CLLocationManagerDelegate {
    
    weak var delegate: LocationManagerDelegate?
    
    private let locationManager: CLLocationManager!
    private var needSendLocation = false
    
    
    required init(delegate: LocationManagerDelegate?) {
        locationManager = CLLocationManager()
        
        super.init()
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
        
        self.delegate = delegate
    }
    
    func getCountryAndCityByCoord(location: CLLocation, completion:@escaping ([AnyHashable :Any]?)->Void) {
        let coder = CLGeocoder()
        let locale = Locale.init(identifier: "en")
        if #available(iOS 11.0, *) {
            coder.reverseGeocodeLocation(location, preferredLocale: locale) { (placemark, error) in
                if error != nil {
                    completion(nil)
                }
                if let point = placemark?.first {
                    completion(point.addressDictionary)
                } else {
                    completion(nil)
                }
            }
        } else {
            // Fallback on earlier versions
            coder.reverseGeocodeLocation(location) { (placemark, error) in
                if error != nil {
                    completion(nil)
                }
                if let point = placemark?.first {
                    completion(point.addressDictionary)
                } else {
                    completion(nil)
                }
            }
        }
    }
    
    func isAuthorizedStatusManager() -> Bool {
        switch CLLocationManager.authorizationStatus() {
        case .notDetermined:
            return false
        case .restricted:
            delegate?.locationManager(self, didFail: .underlyingServiceError)
            return false
        case .denied:
            delegate?.locationManager(self, didFail: .locationServicesDisabled)
            return false
        case .authorizedAlways, .authorizedWhenInUse:
            if !CLLocationManager.locationServicesEnabled() {
                delegate?.locationManager(self, didFail: .locationServicesDisabled)
                return false
            }
            return true
        }
    }
    
    func requestAuthorization() {
        locationManager.requestWhenInUseAuthorization()
    }
    
    func getLocationOneShot() {
        needSendLocation = true
        if isAuthorizedStatusManager() {
            if #available(iOS 9.0, *) {
                locationManager.requestLocation()
            } else {
                locationManager.startUpdatingLocation()
            }
        }
    }
    
    @objc private func sendLocation() {
        if let location = locationManager.location {
            delegate?.locationManager(self, didUpdate: Coordinate(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude))
        }
    }
    
    // MARK: - CLLocationManagerDelegate
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        needSendLocation = false
        sendLocation()
        guard #available(iOS 9.0, *) else {
            locationManager.stopUpdatingLocation()
            return
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if CLLocationManager.authorizationStatus() == .authorizedAlways || CLLocationManager.authorizationStatus() == .authorizedWhenInUse {
            delegate?.locationManagerDidAllowPermission(self)
        }
        
        if needSendLocation {
            getLocationOneShot()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        delegate?.locationManager(self, didFail: .locationNotAvailable)
    }
}
