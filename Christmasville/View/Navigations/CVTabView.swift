//
//  CVTabView.swift
//  Christmasville
//
//  Created by Mike on 6/11/23.
//

import SwiftUI
import Observation

struct CVTabView: View {
    @Environment(\.apiClient) var apiClient: APIClient
    @State var selectedTab = 1
    var authManager = AuthenticationManager()
    
    var body: some View {
        if authManager.user != nil {
            TabView(selection: $selectedTab,
                    content:  {
                ComingSoonView()
//                    .onAppear(){
//                        authManager.signOut()
//                    }
                    .tabItem {
                        Label("Home", image: selectedTab == 1 ? .snowTree3 : .snowTree2)
                    }
                    .tag(1)
                LightsMapView()
                    .tabItem {
                        Label("Lights Map", image: selectedTab == 2 ? .bulb : .bulbSolid)
                    }
                    .tag(2)
                MrsClauseKitchen(apiClient: apiClient)
                    .tabItem {
                        Label("Mrs Cluse's Kitchen", image: selectedTab == 3 ? .gingerbread3 : .gingerbread2)
                    }
                    .tag(3)
                ComingSoonView()
                    .tabItem {
                        Label("Elves shop", image: selectedTab == 4 ? .sleigh3 : .sleigh2)
                    }
                    .tag(4)
                ComingSoonView()
                    .tabItem {
                        Label("Santa's inbox", image: selectedTab == 5 ? .christmasHat3 : .christmasHat2)
                    }
                    .tag(5)
            })
            .tint(.lightgreen)
        } else {
            AuthView()
        }
    }
    
}

#Preview {
    CVTabView()
}
