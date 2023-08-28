//
//  LocationManager.swift
//  Christmasville
//
//  Created by Mike on 6/13/23.
//

import Foundation
import Observation
import CoreLocation

@Observable class LocationManager: NSObject, CLLocationManagerDelegate {
    
    // MARK: - Properties
    
    var locationAuthorizationStatus: CLAuthorizationStatus = .notDetermined
    var locationServicesAvailability: Bool = true
    var showLocationPermissionPrompt: Bool = false
    var askLoctionPermission: Bool = false
    var locationManager = CLLocationManager()
    let geocoder = CLGeocoder()
    
    // MARK: - Initialization
    
    override init() {
        super.init()
        locationManager.delegate = self
    }
    
    // MARK: - Location Services
    
    /// Starts the location services and updates authorization status.
    func startLocationServices() {
        if (CLLocationManager.headingAvailable()) {
            locationServicesAvailability = true
            locationManagerDidChangeAuthorization(locationManager)
        } else {
            locationServicesAvailability = false
        }
    }
    
    /// Requests location permission from the user.
    func askLocationPermission() {
        locationManager.requestWhenInUseAuthorization()
    }
    
    // MARK: - CLLocationManagerDelegate
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        locationAuthorizationStatus = manager.authorizationStatus
        switch manager.authorizationStatus {
        case .authorizedWhenInUse:
            print("Location is authorized")
            manager.startUpdatingLocation()
            
        case .restricted, .denied:
            print("Location is denied")
            
        case .notDetermined:
            showLocationPermissionPrompt.toggle()
            
        default:
            break
        }
    }
    
    // MARK: - Geocoding
    
    /// Converts the current location's coordinates to an `Address`.
    ///
    /// - Returns: An `Address` instance representing the current location.
    /// - Throws: An `Error` if the operation fails.
    func getCurrentLocationAddress() async throws -> Address {
        guard let location = locationManager.location else {
            throw NSError(domain: "LocationUnavailable", code: 1, userInfo: nil)
        }
        
        let placemarks = try await geocoder.reverseGeocodeLocation(location)
        guard let placemark = placemarks.first else {
            throw NSError(domain: "AddressUnavailable", code: 2, userInfo: nil)
        }
        
        return Address(
            street: placemark.thoroughfare ?? "",
            city: placemark.locality ?? "",
            state: placemark.administrativeArea ?? "",
            country: placemark.country ?? "",
            postalCode: placemark.postalCode ?? ""
        )
    }
    
    /// Converts an `Address` to `Coordinates`.
    ///
    /// - Parameters:
    ///   - address: The `Address` to be converted.
    /// - Returns: A `Coordinates` instance representing the given address.
    /// - Throws: An `Error` if the operation fails.
    func getCoordinatesFromAddress(_ address: Address) async throws -> Coordinates {
        let addressString = "\(address.street), \(address.city), \(address.state), \(address.country), \(address.postalCode)"
        
        let placemarks = try await geocoder.geocodeAddressString(addressString)
        guard let placemark = placemarks.first, let location = placemark.location else {
            throw NSError(domain: "CoordinatesUnavailable", code: 3, userInfo: nil)
        }
        
        return Coordinates(
            latitude: location.coordinate.latitude,
            longitude: location.coordinate.longitude
        )
    }
}
