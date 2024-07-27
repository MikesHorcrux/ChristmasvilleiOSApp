//
//  CreateGifteeView.swift
//  Christmasville
//
//  Created by Mike  Van Amburg on 6/10/24.
//

import SwiftUI
import SwiftData

struct CreateGifteeView: View {
    @Environment(\.dismiss) var dismiss
    @Environment(\.modelContext) var modelContext

    @State private var name: String = ""
    @State private var sex: String = ""
    @State private var age: String = ""
    @State private var activities: String = ""
    @State private var interests: String = ""
    @State private var hobbies: String = ""
    @State private var relation: Relation = .friend

    var body: some View {
        Form {
            Section(header: Text("Giftee Information")) {
                TextField("Name", text: $name)
                TextField("Sex", text: $sex)
                TextField("Age", value: $age, formatter: NumberFormatter())
                #if !os(macOS)
                    .keyboardType(.numberPad)
                #endif
            }
            
            Section(header: Text("Additional Information")) {
                TextField("Activities", text: $activities, axis: .vertical)
                TextField("Interests", text: $interests, axis: .vertical)
                TextField("Hobbies", text: $hobbies, axis: .vertical)
            }
            
            Section(header: Text("Relation")) {
                Picker("Relation", selection: $relation) {
                    ForEach(Relation.allCases, id: \.self) { relation in
                        Text(relation.rawValue.capitalized).tag(relation)
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
            }
            
            HStack {
                Spacer()
                Image("leaf")
                    .resizable()
                    .scaledToFit()
                    .frame(height: 110)
                Spacer()
            }
            .listRowBackground(Color.clear)
        }
        #if !os(macOS)
        .navigationBarTitleDisplayMode(.inline)
        #endif
        .toolbar(content: {
            ToolbarItem(placement: .automatic) {
                Button("Save") {
                    saveGiftee()
                }
                .buttonStyle(BorderedProminentButtonStyle())
            }
        })
#if os(iOS)
        .toolbar(.hidden, for: .tabBar)
        #endif
        .snowBackground()
    }
    
    func saveGiftee() {
        let gifttee = Giftee(name: name, sex: sex, age: age, activities: activities, interests: interests, hobbies: hobbies, relation: relation)
        modelContext.insert(gifttee)
        dismiss()
    }
}

#Preview {
    CreateGifteeView()
}
