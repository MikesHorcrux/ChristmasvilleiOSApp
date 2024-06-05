//
//  SWEmptyPage.swift
//  Christmasville
//
//  Created by Mike  Van Amburg on 6/4/24.
//

import SwiftUI

struct SWEmptyPage: View {
    var body: some View {
        VStack {
            Image("hand with gift_angle")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 300)
                .padding(.top, 100)
            Text("Ho Ho Ho! Welcome to my workshop! Please add a profile for the ones you want to give a gift. This will help Santa keep track of all your special people and their unique preferences!")
                .padding()
                .opacity(0.65)
            Spacer()
        }
        .frame(maxWidth: .infinity)
        .snowBackground()
    }
}

#Preview {
    SWEmptyPage()
}
