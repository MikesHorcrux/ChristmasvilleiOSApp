//
//  HomeView.swift
//  Christmasville
//
//  Created by Mike  Van Amburg on 10/6/23.
//

import SwiftUI
import Observation
import MapKit


struct HomeView: View {
    @Binding var selectedTab: Int
   
    var body: some View {
        NavigationStack() {
            VStack {
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
                    Spacer()
                    HStack {
                        Text("Days Untill Christmas: ")
                        CountdownView()
                    }
                    .padding()
                    .neumorphicBackground()
                    Spacer()
                    HStack{
                        Image("santa with snowball")
                            .resizable()
                            .scaledToFit()
                        Spacer()
                        Image("snowman")
                            .resizable()
                            .scaledToFit()
                    }
                    .frame(height: 130)
                    .padding()
                }
                .padding()
                .snowBackground()
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
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
}

#Preview {
    HomeView(selectedTab: .constant(0))
}

