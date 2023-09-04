//
//  CVTabView.swift
//  Christmasville
//
//  Created by Mike on 6/11/23.
//

import SwiftUI
import Observation

struct CVTabView: View {
    @State var selectedTab = 1
    var authManager = AuthenticationManager()
    
    var body: some View {
        if authManager.user != nil {
            TabView(selection: $selectedTab,
                    content:  {
                Text("Tab Content 1")
                    .tabItem {
                        Label("Home", image: selectedTab == 1 ? .snowTree3 : .snowTree2)
                    }
                    .tag(1)
                LightsMapView()
                    .tabItem {
                        Label("Lights Map", image: selectedTab == 2 ? .bulb : .bulbSolid)
                    }
                    .tag(2)
                Text("Tab Content 1")
                    .tabItem {
                        Label("Mrs Cluse's Kitchen", image: selectedTab == 3 ? .gingerbread3 : .gingerbread2)
                    }
                    .tag(3)
                Text("Tab Content 2")
                    .tabItem {
                        Label("Elves shop", image: selectedTab == 4 ? .sleigh3 : .sleigh2)
                    }
                    .tag(4)
                Text("Tab Content 2")
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
