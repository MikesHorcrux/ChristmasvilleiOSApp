//
//  GifteeCard.swift
//  Christmasville
//
//  Created by Mike Van Amburg on 6/17/24.
//

import SwiftUI

struct GifteeCard: View {
    
    var giftee: Giftee
    var hideGiftInfo: Bool = false
    
    var body: some View {
        HStack(alignment: hideGiftInfo ? .center: .top) {
            giftImageView
                .padding(.trailing, 5)
            VStack(alignment: .leading) {
                mainCardContent
                if !hideGiftInfo {
                    giftStatusView
                    trackingNumberView
                }
            }
            Spacer()
        }
    }
    
    // Main card content view
    private var mainCardContent: some View {
        Text(giftee.name)
            .font(.headline)
    }
    
    // Gift image view with red border
    private var giftImageView: some View {
        Image("gift #2")
            .resizable()
            .scaledToFit()
            .padding(9)
            .frame(width: 40, height: 40)
            .background()
            .clipShape(Circle())
            .overlay(
                Circle().stroke(Color.red, lineWidth: 2)
            )
    }
    
    // Gift status view
    private var giftStatusView: some View {
        HStack {
            Text("Gift Status:")
                .bold()
                .foregroundColor(Color.red)
            Text(giftee.giftStatus.rawValue)
                .font(.subheadline)
        }
    }
    
    // Tracking number view (optional)
    private var trackingNumberView: some View {
        Group {
            if let trackingNumber = giftee.trackingNumber {
                HStack {
                    Text("Tracking #:")
                        .bold()
                        .foregroundColor(Color.red)
                    Text(trackingNumber)
                        .font(.subheadline)
                }
            }
        }
    }
}

#Preview {
    GifteeCard(giftee: Giftee(name: "Elf Jim", sex: "Male", age: "120", relation: .colleague, trackingNumber: "18293848-38329398"))
}

#Preview {
    GifteeCard(giftee: Giftee(name: "Elf Jim", sex: "Male", age: "120", relation: .colleague))
}
