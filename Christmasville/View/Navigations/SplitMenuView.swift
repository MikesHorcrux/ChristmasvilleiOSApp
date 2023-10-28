//
//  SplitMenuView.swift
//  Christmasville
//
//  Created by Mike on 6/11/23.
//

import SwiftUI
import Observation

struct SplitMenuView: View {
    @Environment(\.apiClient) var apiClient: APIClient
    @State var showHome: Bool = false
    var authManager = AuthenticationManager()
    var body: some View {
        NavigationSplitView {
            List {
                NavigationLink(destination: ComingSoonView()) {
                    Label {
                        Text("Home")
                    } icon: {
                        Image(.snowTree3)
                            .resizable()
                            .scaledToFit()
                            .foregroundColor(.lightgreen)
                    }

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
                NavigationLink(destination:  MrsClauseKitchen(apiClient: apiClient)) {
                    Label {
                        Text("Mrs Cluse's Kitchen")
                    } icon: {
                        Image(.gingerbread3)
                            .resizable()
                            .scaledToFit()
                            .foregroundColor(.lightgreen)
                    }

                }
                NavigationLink(destination: ComingSoonView()) {
                    Label {
                        Text("Elves shop")
                    } icon: {
                        Image(.sleigh3)
                            .resizable()
                            .scaledToFit()
                            .foregroundColor(.lightgreen)
                    }

                }
                NavigationLink(destination: ComingSoonView()) {
                    Label {
                        Text("Santa's inbox")
                    } icon: {
                        Image(.christmasHat3)
                            .resizable()
                            .scaledToFit()
                            .foregroundColor(.lightgreen)
                    }

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
