//
//  NewGifteeView.swift
//  Christmasville
//
//  Created by Mike  Van Amburg on 6/4/24.
//

import SwiftUI
import SwiftData

struct EditGifteeView: View {
    @Environment(\.dismiss) var dismiss
    @Environment(\.modelContext) var modelContext
    @Bindable var giftee: Giftee
    
    var body: some View {
        Form {
            Section(header: Text("Giftee Information")) {
                TextField("Name", text: $giftee.name)
                TextField("Sex", text: $giftee.sex)
                TextField("Age", value: $giftee.age, formatter: NumberFormatter())
                    .keyboardType(.numberPad)
            }
            
            
            Section(header: Text("Additional Information")) {
                TextField("Activities", text: $giftee.activities, axis: .vertical)
                TextField("Interests", text: $giftee.interests, axis: .vertical)
                TextField("Hobbies", text: $giftee.hobbies, axis: .vertical)
            }
            
            
            Section(header: Text("Relation")) {
                Picker("Relation", selection: $giftee.relation) {
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
        .navigationBarTitleDisplayMode(.inline)
        .toolbar(content: {
            ToolbarItem(placement: .automatic) {
                Button("Done") {
                    dismiss()
                }
                .buttonStyle(BorderedButtonStyle())
            }
        })
    }
    
}

#Preview {
    do {
           let config = ModelConfiguration(isStoredInMemoryOnly: true)
           let container = try ModelContainer(for: Giftee.self, configurations: config)
        return  
        NavigationStack{
            EditGifteeView(giftee: Giftee(name: "Santa", sex: "Male", age: "100", relation: .family))
                .modelContainer(container)
        }
       } catch {
           fatalError("Failed to create model container.")
       }
    
}
