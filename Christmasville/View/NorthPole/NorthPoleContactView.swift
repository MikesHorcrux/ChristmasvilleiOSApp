//
//  NorthPoleContent.swift
//  Christmasville
//
//  Created by Mike  Van Amburg on 9/2/24.
//

import SwiftUI

struct NorthPoleContactView: View {
    var image: String
    var name: String
    var body: some View {
        HStack{
            Image(image)
                .resizable()
                .scaledToFit()
                .frame(width: 55, height: 55)
                .clipShape(Circle())
                .overlay(
                    Circle().stroke(Color.santaRed, lineWidth: 1)
                )
                .padding(.trailing)
            Text(name)
                .fontWeight(.semibold)
                .font(.title3)
            Spacer()
        }
        .padding()
    }
}

#Preview {
    NorthPoleContactView(image: "santa with snowball_angle", name: "Santa")
}
