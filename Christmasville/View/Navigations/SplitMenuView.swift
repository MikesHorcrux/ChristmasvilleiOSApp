//
//  SplitMenuView.swift
//  Christmasville
//
//  Created by Mike on 6/11/23.
//

import SwiftUI
import Observation

struct SplitMenuView: View {
    @State var showHome: Bool = false
    var authManager = AuthenticationManager()
    var body: some View {
        NavigationSplitView {
            List {
                NavigationLink(destination: Text("home"), isActive: $showHome) {
                    Label("Home", systemImage: "circle")
                }
                NavigationLink(destination: LightsMapView()) {
                    Label {
                        Text("Lights Map")
                    } icon: {
                        Image(.bulb)
                            .resizable()
                            .scaledToFit()
                            .foregroundColor(.lightgreen)
                    }

                }
                NavigationLink(destination: Text("kitchen view")) {
                    Label("Mrs Cluse's Kitchen", systemImage: "circle")
                }
                NavigationLink(destination: Text("shop view")) {
                    Label("Elves shop", systemImage: "circle")
                }
                NavigationLink(destination: Text("inbox view")) {
                    Label("Santa's inbox", systemImage: "circle")
                }
            }
            .listStyle(.sidebar)
        } detail: {
            AuthView()
                .onAppear(){
                    if authManager.user != nil {
                        showHome.toggle()
                    }
                }
        }
    }
    
}

#Preview {
    SplitMenuView()
}
