//
//  CookBookEmptyView.swift
//  Christmasville
//
//  Created by Mike  Van Amburg on 8/24/24.
//

import SwiftUI

struct CookBookEmptyView: View {
    var body: some View {
        VStack {
            Image("ginger breadman")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 230)
                .padding(.top, 100)
            Text("Oh dear! It looks like you don’t have any recipes saved yet. Don’t worry, it’s Mrs. Claus here to help! Be sure to stop by my kitchen for a chat—I’d love to share some of my favorite holiday recipes with you!")
                .padding()
                .opacity(0.65)
                .background(Color("SnowBackground").opacity(0.8))
                .clipShape(RoundedRectangle(cornerRadius: 20))
            Spacer()
        }
    }
}

#Preview {
    CookBookEmptyView()
}
