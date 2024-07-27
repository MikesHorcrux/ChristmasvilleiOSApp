//
//  MiniMapView.swift
//  Christmasville
//
//  Created by Mike  Van Amburg on 7/15/24.
//

import SwiftUI
import MapKit
import SwiftData
import Observation

struct MiniMapView: View {
    @Query var clLocations: [ChristmasLightsLocation]
    @Bindable var locationManager: LocationManager = LocationManager()
    @State var position: MapCameraPosition = .userLocation(fallback: .automatic)

    var body: some View {
        Map(position: $position, interactionModes: []){
            //UserAnnotation()
            ForEach(clLocations, id: \.id) { location in
                Annotation(location.nickname ?? "", coordinate: CLLocationCoordinate2D(latitude: location.coordinates.latitude, longitude: location.coordinates.longitude)) {
                    LightLocationLabel()
                }
            }
        }
        .mapStyle(.standard)
        
    }
}

#Preview {
    MiniMapView()
}
