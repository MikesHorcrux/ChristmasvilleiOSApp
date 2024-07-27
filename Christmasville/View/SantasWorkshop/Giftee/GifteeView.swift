//
//  GifteeView.swift
//  Christmasville
//
//  Created by Mike  Van Amburg on 6/21/24.
//

import SwiftUI

struct GifteeView: View {
    
    @Environment(\.modelContext) var modelContext
    @Bindable var giftee: Giftee
    
    var body: some View {

        ScrollView {
                    VStack {
                        HStack(alignment: .top){
                            VStack(alignment: .leading) {
                                VStack(alignment: .leading) {
                                    Text("Name: ")
                                        .font(.headline)
                                        .foregroundStyle(Color.santaRed)
                                    Text(giftee.name)
                                        .padding(.bottom, 2)
                                }
                                VStack(alignment: .leading) {
                                    Text("Sex: ")
                                        .font(.headline)
                                        .foregroundStyle(Color.santaRed)
                                    Text(giftee.sex)
                                        .padding(.bottom, 2)
                                }
                            }
                            .padding(.trailing, 50)
                         
                            VStack(alignment: .leading) {
                                VStack(alignment: .leading) {
                                                                    Text("Relation: ")
                                    .font(.headline)
                                    .foregroundStyle(Color.santaRed)
                                                                    Text(giftee.relation.rawValue)
                                                                }
                                                                VStack(alignment: .leading) {
                                                                    Text("Age: ")
                                                                        .font(.headline)
                                                                        .foregroundStyle(Color.santaRed)
                                                                    Text(giftee.age)
                                                                        .padding(.bottom, 2)
                                                                }
                            }
                            Spacer()
                        }
                        .padding()
                        .neumorphicBackground()
                        .padding()
                        
                        VStack(alignment: .leading) {
                            if let trackingNumber = giftee.trackingNumber, !trackingNumber.isEmpty, giftee.giftStatus == .shipped {
                                VStack(alignment: .leading) {
                                    Text("Tracking Number: ")
                                        .font(.headline)
                                        .foregroundStyle(Color.santaRed)
                                    Text(trackingNumber)
                                        .padding(.bottom, 2)
                                }
                            }
                            
                            Picker("Gift Status", selection: $giftee.giftStatus) {
                                ForEach(GiftStatus.allCases, id: \.self) { status in
                                    VStack(alignment: .leading) {
                                        Text(status.rawValue.capitalized)
                                            .font(.caption)
                                            .foregroundColor(.santaRed)
                                        Text(status.description)
                                            .multilineTextAlignment(.leading)
                                    }
                                }
                                .padding(.vertical)
                            }
                            #if os(macOS)
                            .pickerStyle(.menu)
                            #else
                            .pickerStyle(.navigationLink)
                            #endif
                            .padding()
                        }
                        .padding()
                        .neumorphicBackground()
                        .padding()
                    }
                HStack {
                    VStack(alignment: .leading) {
                        Text("Activities: ")
                            .font(.headline)
                            .foregroundStyle(Color.santaRed)
                        Text(giftee.activities)
                    }
                    Spacer()
                }
                .padding()
                .neumorphicBackground()
                .padding()
                
                HStack {
                    VStack(alignment: .leading) {
                        Text("Interests: ")
                            .font(.headline)
                            .foregroundStyle(Color.santaRed)
                        Text(giftee.interests)
                    }
                    Spacer()
                }
                .padding()
                .neumorphicBackground()
                .padding()
               
                HStack {
                    VStack(alignment: .leading) {
                        Text("Hobbies: ")
                            .font(.headline)
                            .foregroundStyle(Color.santaRed)
                        Text(giftee.hobbies)
                    }
                    Spacer()
                }
                .padding()
                .neumorphicBackground()
                .padding()
            }
            .multilineTextAlignment(.leading)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .snowBackground()
            .navigationTitle(giftee.name)
        #if !os(macOS)
            .navigationBarTitleDisplayMode(.inline)
        #endif
            .toolbar {
                ToolbarItem(placement: .automatic) {
                    NavigationLink("Edit", destination: EditGifteeView(giftee: giftee))
                        .buttonStyle(BorderedProminentButtonStyle())
                }
            }  
#if os(iOS)
            .toolbar(.hidden, for: .tabBar)
#endif
        }
    
}

#Preview {
    NavigationStack {
        var giftee = Giftee(
            name: "Alice",
            sex: "Female",
            age: "25",
            activities: "Attending Christmas Markets, Ice Skating",
            interests: "Christmas Movies, Baking Gingerbread Cookies",
            hobbies: "Knitting Christmas Sweaters, Decorating Christmas TreesKnitting Christmas Sweaters, Decorating Christmas TreesKnitting Christmas Sweaters, Decorating Christmas TreesKnitting Christmas Sweaters, Decorating Christmas TreesKnitting Christmas Sweaters, Decorating Christmas TreesKnitting Christmas Sweaters, Decorating Christmas TreesKnitting Christmas Sweaters, Decorating Christmas TreesKnitting Christmas Sweaters, Decorating Christmas TreesKnitting Christmas Sweaters, Decorating Christmas TreesKnitting Christmas Sweaters, Decorating Christmas TreesKnitting Christmas Sweaters, Decorating Christmas Trees",
            relation: .friend,
            giftStatus: .shipped,
            trackingNumber: "XYZ123456789"
        )
        GifteeView(giftee: giftee)
    }
}
