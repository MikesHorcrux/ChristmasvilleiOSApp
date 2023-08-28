//
//  LocationServicesDeniedView.swift
//  Christmasville
//
//  Created by Mike on 6/14/23.
//

import SwiftUI

struct LocationServicesDeniedView: View {
    var body: some View {
        #if os(macOS)
        content
            .frame(maxHeight: 630)
            .interactiveDismissDisabled()
        #else
        content
            .frame(maxHeight: 900)
            .interactiveDismissDisabled()
        #endif
    }
    
    var content: some View {
        VStack{
            Spacer()
            Text("Ho, ho, ho! Seems like my reindeer and I missed a turn. To help guide us, could you please head to your settings and switch on location services? It's the key to unlocking all the merry map features. Thanks, and let's keep the Christmas spirit going!")
                .font(.title3)
                .fixedSize(horizontal: false, vertical: true) // Add this line
                .padding()
                .background(.thinMaterial.opacity(0.7))
                .cornerRadius(18)
                .padding()
                .frame(maxWidth: 450)
                .multilineTextAlignment(.center)
            Image("santa on the ground")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(height: 300)
                .padding()
            Spacer()
        }
        .padding(.bottom, 30)
        .padding(.top)
        .background(SnowBackground().ignoresSafeArea(edges: .all))
    }
}

#Preview {
    LocationServicesDeniedView()
}
