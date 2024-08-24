//
//  HomeView.swift
//  Christmasville
//
//  Created by Mike  Van Amburg on 10/6/23.
//

import SwiftUI
import Observation
import MapKit
import SwiftData


struct HomeView: View {
    @Binding var selectedTab: Tabs
    @Query var giftees: [Giftee]
    @Query var recipes: [Recipe]
   
    var body: some View {
      NavigationStack() {
            
          ScrollView{
                    VStack {
                        HStack{
                            Image("wreath")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 50)
                            VStack(alignment: .leading) {
                                Text("Merry")
                                    .foregroundStyle(.everGreen)
                                Text("Christmas")
                                    .foregroundStyle(.santaRed)
                                    .padding(.leading)
                            }
                            .fontWidth(.expanded)
                            .fontWeight(.bold)
                            .padding(5)
                            Image("wreath")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 50)
                        }
                        .padding()
                        .neumorphicBackground()
                        .padding()
                        
                        HStack {
                            Spacer()
                            VStack {
                                Text("Days Untill Christmas: ")
                                    .font(.title2)
                                    .fontWeight(.bold)
                                    .foregroundStyle(.everGreen)
                                    .padding(.bottom, 30)
                                CountdownView()
                            }
                            .frame(maxWidth: 400, maxHeight: 200)
                            .padding()
                            .neumorphicBackground()
                            Spacer()
                            VStack {
                                MiniMapView()
                            }
                            .frame(maxWidth: 400, maxHeight: 230)
                            .clipShape(RoundedRectangle(cornerRadius: 20))
                            .onTapGesture {
                                selectedTab = .lightsMap
                            }
                            Spacer()
                        }
                        .padding()
                        
                        VStack(alignment: .leading) {
                            Text("Santas List: ")
                                .font(.callout)
                                .fontWeight(.bold)
                                .foregroundStyle(.everGreen)
                            if giftees.isEmpty {
                                HStack {
                                    Spacer()
                                    VStack {
                                        Image("santa stuck in pipe_angle")
                                            .resizable()
                                            .scaledToFit()
                                            .frame(width: 100, height: 100)
                                            .padding()
                                        Text("No has been added yet.")
                                            .font(.footnote)
                                            .fontWeight(.bold)
                                            .foregroundStyle(.everGreen)
                                    }
                                    Spacer()
                                }
                            } else {
                                ForEach(giftees.suffix(3)) { giftee in
                                        GifteeCard(giftee: giftee)
                                    }
                            }
                            
                        }
                        .padding()
                        .frame(maxWidth: .infinity, maxHeight: 350)
                        .neumorphicBackground()
                        .padding()
                        .onTapGesture {
                            selectedTab = .santasList
                        }
                       
                        VStack(alignment: .leading) {
                            Text("CookBook: ")
                                .font(.callout)
                                .fontWeight(.bold)
                                .foregroundStyle(.everGreen)
                            
                            if recipes.isEmpty {
                                HStack {
                                    Spacer()
                                    VStack {
                                        Image("tartlet")
                                            .resizable()
                                            .scaledToFit()
                                            .frame(width: 100, height: 100)
                                            .padding()
                                        Text("No Recipes Found")
                                            .font(.footnote)
                                            .fontWeight(.bold)
                                            .foregroundStyle(.everGreen)
                                    }
                                    Spacer()
                                }
                            } else {
                                ScrollView(.horizontal) {
                                    HStack {
                                        ForEach(recipes.suffix(5)) { recipe in
                                            MiniRecipeCard(recipe: recipe)
                                        }
                                    }
                                }
                            }
                        }
                        .padding()
                        .frame(maxWidth: .infinity, maxHeight: 300)
                        .neumorphicBackground()
                        .padding()
                        .onTapGesture {
                            selectedTab = .cookbook
                        }

                        ZStack(alignment: .bottom) {
                            SnowHillsView()
                            HStack{
                                Image("santa with snowball")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 150, height: 150)
                                Spacer()
                                Image("snowman")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 150, height: 150)
                            }
                            .padding(.horizontal)
                        }
                        
                    }
                }
            .snowBackground()
#if !os(macOS)
            .toolbarBackground(.hidden, for: .navigationBar)
#endif
            
            .toolbar {
                ToolbarItem(placement: .automatic) {
                    NavigationLink {
                        Text("settings view Coming soon")
                    } label: {
                        Image(systemName: "gearshape.fill")
                    }
                    .buttonStyle(RoundGreenButtonStyle(padding: 2))
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

   return HomeView(selectedTab: .constant(.home))
        .modelContainer(container)
}

