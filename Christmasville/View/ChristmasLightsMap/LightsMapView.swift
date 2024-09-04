//
//  LightsMapView.swift
//  Christmasville
//
//  Created by Mike on 6/11/23.
//

import SwiftUI
import MapKit
import CoreLocation
import Observation
import SwiftData

/// A view representing a map for Christmas lights.
///
/// This view shows a map and a button to add a new address for Christmas lights.
struct LightsMapView: View {
    @Query var clLocations: [ChristmasLightsLocation]
    @Bindable var locationManager: LocationManager = LocationManager()
    @State var selectedLocation: ChristmasLightsLocation = ChristmasLightsLocation(address: Address(street: "", city: "", state: "", country: "", postalCode: ""), coordinates: Coordinates(latitude: 0, longitude: 0), houseType: .amazing)
    @State var position: MapCameraPosition = .userLocation(fallback: .automatic)
    @State private var showAddAddress = false
    @State private var showAddAddressSheet = false
    @State var showLocationInfo = false
    
    var body: some View {
        NavigationStack() {
        mapSection
            .sheet(isPresented: $locationManager.showLocationPermissionPrompt, onDismiss: {
                if locationManager.askLoctionPermission {
                    locationManager.askLocationPermission()
                }
            }) {
                LocationServicesInitalPermissionView(locationManager: locationManager)
            }
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    NavigationLink() {
                        AddAddressForm(locationManager: locationManager)
                    } label: {
                        HStack {
                            Image("Bulbs")
                            Text("Add House")
                        }
                    }
                    .buttonStyle(BorderedProminentButtonStyle())
                
                }
            }
#if !os(macOS)
            .toolbarBackground(.hidden, for: .navigationBar)
#endif
            
        }
    }
    
    /// Map section of the view.
    ///
    /// This section includes the map view.
    private var mapSection: some View {
        Map(position: $position){
            //UserAnnotation()
            ForEach(clLocations, id: \.id) { location in
                Annotation(location.nickname ?? "", coordinate: CLLocationCoordinate2D(latitude: location.coordinates.latitude, longitude: location.coordinates.longitude)) {
                    LightLocationLabel()
                        .onTapGesture {
                            selectedLocation = location
                            showLocationInfo = true
                        }
                        .sheet(isPresented: $showLocationInfo) {
                            LocationProfileView(location: $selectedLocation)
                                .presentationDetents([.medium, .large])
                                .presentationDragIndicator(.visible)
                        }
                }
            }
        }
        .mapStyle(.standard)

    }
}

#Preview {
    LightsMapView()
}
