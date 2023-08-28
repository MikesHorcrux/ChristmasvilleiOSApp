//
//  LocationServicesInitalPermissionView.swift
//  Christmasville
//
//  Created by Mike on 6/14/23.
//

import SwiftUI
import Observation

struct LocationServicesInitalPermissionView: View {
    @Environment(\.dismiss) private var dismiss
        @Bindable var locationManager: LocationManager
        var body: some View {
            #if os(macOS)
            content
                .frame(maxHeight: 630)
            #else
            content
                .frame(maxHeight: 900)
            #endif
        }
        
        var content: some View {
            VStack{
                Text("Ho, ho, ho! Santa's got a quick favor to ask - mind if I check your location? It's just to bring more joy and holiday cheer straight to you. No personal details kept - it's all about the Christmas magic! Are you in?")
                    .font(.title3)
                    .fixedSize(horizontal: false, vertical: true) // Add this line
                    .padding()
                    .background(.thinMaterial.opacity(0.7))
                    .cornerRadius(18)
                    .padding()
                    .frame(maxWidth: 450)
                    .multilineTextAlignment(.center)
                Image("santa hugging deer")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(height: 300)
                Spacer()
                Button("Continue") {
                    locationManager.askLoctionPermission.toggle()
                    dismiss()
                }
                .buttonStyle(SantaRedPillButtonStyle())
            }
            .padding(.bottom, 30)
            .padding(.top)
            .background(SnowBackground().ignoresSafeArea(edges: .all))
        }
}

#Preview {
    LocationServicesInitalPermissionView(locationManager: LocationManager())
}
