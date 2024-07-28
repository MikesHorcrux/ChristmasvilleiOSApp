//
//  LightLocationLabel.swift
//  Christmasville
//
//  Created by Mike on 8/1/23.
//

import SwiftUI

struct LightLocationLabel: View {
    var body: some View {
        ZStack {
            Circle()
                .strokeBorder(Color.lightgreen, lineWidth: 1.5)
                .background(Circle().foregroundColor(.bellBrown))
                .frame(width: 40, height: 40)
            
            Image("home globe")
                .resizable()
                .scaledToFit()
                .frame(width: 40)
        }
    }
}

#Preview {
    LightLocationLabel()
}
