//
//  GifteeChatSelection.swift
//  Christmasville
//
//  Created by Mike  Van Amburg on 7/14/24.
//

import SwiftUI
import SwiftData

struct GifteeChatSelection: View {
    @Query var giftees: [Giftee]
    var action: (() -> Void)?
    var body: some View {
        List {
            Text("Select a Giftee")
                .bold()
                .foregroundStyle(.santaRed)
            ForEach(giftees) { giftee in
                Button(action: {
                    if let action = action {
                        action()
                    }
                }) {
                    GifteeCard(giftee: giftee, hideGiftInfo: true)
                }
            }
        }
        
    }
}

#Preview {
    var previewData: [Giftee] = [
        Giftee(name: "Mike", sex: "Male", age: "25", activities: "Swimming, Basketball", interests: "Cooking, Video Games", hobbies: "Hiking, Camping", relation: .family, giftStatus: .purchased, trackingNumber: "123456789"),
        Giftee(name: "Sarah", sex: "Female", age: "23", activities: "Swimming, Basketball", interests: "Cooking, Video Games", hobbies: "Hiking, Camping", relation: .family, giftStatus: .purchased, trackingNumber: "123456789"),
        Giftee(name: "John", sex: "Male", age: "27", activities: "Swimming, Basketball", interests: "Cooking, Video Games", hobbies: "Hiking, Camping", relation: .family, giftStatus: .purchased, trackingNumber: "123456789"),
        ]
    
    let config = ModelConfiguration(isStoredInMemoryOnly: true)
    let container = try! ModelContainer(for: Giftee.self, configurations: config)

        for giftee in previewData{
            container.mainContext.insert(giftee)
        }

    return GifteeChatSelection(){
        print("tapped")
    }
        .modelContainer(container)
}
