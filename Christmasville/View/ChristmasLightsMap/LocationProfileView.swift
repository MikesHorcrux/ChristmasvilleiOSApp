//
//  LocationProfileView.swift
//  Christmasville
//
//  Created by Mike on 8/3/23.
//

import SwiftUI
import Observation
struct LocationProfileView: View {
    @Environment(\.dismiss) var dismiss
    @Binding var location: ChristmasLightsLocation
    var body: some View {
        VStack {
            HStack {
                Image("snowman")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 80)
                Text(location.houseType == .amazing ? "Pass" : "Fail")
                                .font(.title)
                                .fontWeight(.bold)
                                .foregroundStyle(location.houseType == .amazing ? Color.green : Color.red)
                                .padding(.vertical, 6)
                                .padding(.horizontal, 50)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 20)
                                        .stroke(location.houseType == .amazing ? Color.green : Color.red, lineWidth: 5)
                            )
                Image("santa with Christmas tree")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 80)
            }
            .padding()
            HStack {
                ZStack {
                    VStack(alignment: .leading) {
                        Text("Address: ")
                            .font(.title2)
                            .fontWeight(.bold)
                            .padding(.bottom)
                        Text(location.address.street)
                            .font(.headline)
                        Text(location.address.city)
                        Text("\(location.address.state), \(location.address.postalCode)")
                        Text(location.address.country)
                    }
                    .padding() // Add padding to the VStack content
                    .neumorphicBackground()
                    .padding(20) // Padding around the entire ZStack content if desired
                }
                Spacer()
            }
            .padding()
            Spacer()
        }
        .padding(.top)
        .background(SnowBackground().ignoresSafeArea(edges: .all))
        .toolbar {
#if os(macOS)
            ToolbarItem(placement: .cancellationAction) {
                Button(action: {
                    dismiss()
                }, label: {
                    Image(systemName: "arrowshape.backward")
                        .font(.title2)
                }
                       )
                .buttonStyle(BorderedProminentButtonStyle())
            }
#endif
        }
    }
}

#Preview {
    LocationProfileView(location: .constant(
        ChristmasLightsLocation(
            address: Address(
                street: "123 Christmas St",
                city: "North Pole",
                state: "Alaska",
                country: "USA",
                postalCode: "99705"
            ),
            coordinates: Coordinates(
                id: UUID(),
                latitude: 64.7511,
                longitude: -147.3494
            ),
            houseType: .fail
        )
    )
                        )

}
