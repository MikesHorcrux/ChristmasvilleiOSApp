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
    @State private var mrsClauseKitchen: MrsClauseKitchenViewModel
    @State private var mrsClauseChat: MrsClauseKitchenChatViewModel
    @State private var christmasLightMap: CLMViewModel
    @State var position: MapCameraPosition = .userLocation(fallback: .automatic)
    init(apiClient: APIClient, selectedTab: Binding<Int>) {
        _mrsClauseKitchen = State(initialValue: MrsClauseKitchenViewModel())
        _mrsClauseChat = State(initialValue: MrsClauseKitchenChatViewModel(client: apiClient))
        _christmasLightMap = State(initialValue: CLMViewModel())
        _selectedTab = selectedTab
    }
    var body: some View {
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
        .onAppear(){
            Task{
                await mrsClauseKitchen.getSavedMrsClauseRecipes()
                await christmasLightMap.getUserSavedLocations()
            }
        }
    }
}

#Preview {
    HomeView(apiClient: InMemoryAPIClient(), selectedTab: .constant(0))
}

