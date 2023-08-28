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
                        Label("Home", systemImage: "circle")
                    }
                    .tag(1)
                LightsMapView()
                    .tabItem {
                        Label("Lights Map", image: selectedTab == 2 ? .bulb : .bulbSolid)
                    }
                    .tag(2)
                Text("Tab Content 1")
                    .tabItem {
                        Label("Mrs Cluse's Kitchen", systemImage: "circle")
                    }
                    .tag(3)
                Text("Tab Content 2")
                    .tabItem {
                        Label("Elves shop", systemImage: "circle")
                    }
                    .tag(4)
                Text("Tab Content 2")
                    .tabItem {
                        Label("Santa's inbox", systemImage: "circle")
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
