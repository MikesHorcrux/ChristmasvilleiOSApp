//
//  MainView.swift
//  Christmasville
//
//  Created by Mike on 6/11/23.
//

import SwiftUI
import RevenueCat
import RevenueCatUI

struct MainView: View {
    
    @Bindable var subscriptions: SubscriptionManager
    @State var selectedTab: Tabs = .home
    
    var body: some View {
        TabView(selection: $selectedTab) {
            
            Tab(value: .home) {
                HomeView(selectedTab: $selectedTab)
                   
            } label: {
                if selectedTab == .home {
                    Label("Home", image: .snowTree3)
                } else {
                    Label("Home", image: .snowTree2)
                }
            }
            
            Tab(value: .lightsMap) {
                LightsMapView()
                   
                
            } label: {
                if selectedTab == .lightsMap {
                    Label("Lights Map", image: .bulb)
                } else {
                    Label("Lights Map", image: .bulbSolid)
                }
            }
            
            Tab(value: .cookbook) {
                MrsClauseKitchen()
                   
            } label: {
                if selectedTab == .cookbook {
                    Label("Cookbook", image: .gingerbread3)
                } else {
                    Label("Cookbook", image: .gingerbread2)
                }
            }
            
            Tab(value: .santasList) {
                SantasWorkshop()
            } label: {
                if selectedTab == .santasList
                {
                    Label("Santas List", image: .gift3)
                } else {
                    Label("Santas List", image: .gift2)
                }
            }
            
#if !os(macOS)
            if UIDevice.current.userInterfaceIdiom == .phone {
                Tab(value: .northPoleIPhone) {
                    NorthPoleView()
                } label: {
                    if selectedTab == .northPoleIPhone {
                        Label("North Pole", image: .christmasHat3)
                    } else {
                        Label("North Pole", image: .christmasHat2)
                    }
                }
            }
#endif
            
             //North pole for all decives but iphone
            
#if os(macOS)
            TabSection {
                Tab(value: Tabs.northPole(.santa)) {
                    ChatView(bot: .santa)
                     
                } label: {
                    if selectedTab == .northPole(.santa){
                        Label("Santa", image: .sleigh3)
                    } else {
                        Label("Santa", image: .sleigh2)
                    }
                }
                
                Tab(value: Tabs.northPole(.mrsClaus)) {
                    ChatView(bot: .mrsClaus)
                        
                } label: {
                    if selectedTab == .northPole(.mrsClaus){
                        Label("Mrs. Claus", image: .christmasMug1)
                    } else {
                        Label("Mrs. Claus", image: .christmasMug1)
                    }
                }
                
                Tab(value: Tabs.northPole(.santasWorkshop)) {
                    ChatView(bot: .santasWorkshop)
                } label: {
                    Label("Santa's Workshop", image: .sock3)
                }
                
                
            } header: {
                Label("NorthPole", image: .christmasHat2)
            }
            
#else
            if UIDevice.current.userInterfaceIdiom != .phone {
                TabSection {
                    Tab(value: Tabs.northPole(.santa)) {
                        ChatView(bot: .santa)
                           
                    } label: {
                        if selectedTab == .northPole(.santa){
                            Label("Santa", image: .sleigh3)
                        } else {
                            Label("Santa", image: .sleigh2)
                        }
                    }
                    
                    Tab(value: Tabs.northPole(.mrsClaus)) {
                        ChatView(bot: .mrsClaus)
                           
                    } label: {
                        if selectedTab == .northPole(.mrsClaus){
                            Label("Mrs. Claus", image: .christmasMug1)
                        } else {
                            Label("Mrs. Claus", image: .christmasMug1)
                        }
                    }
                    
                    Tab(value: Tabs.northPole(.santasWorkshop)) {
                        ChatView(bot: .santasWorkshop)
                    } label: {
                        Label("Santa's Workshop", image: .sock3)
                    }
                    
                    
                } header: {
                    Label("NorthPole", image: .christmasHat2)
                }
                
            }
#endif
        }
        .tabViewStyle(.sidebarAdaptable)
//        .presentPaywallIfNeeded(requiredEntitlementIdentifier: "Yearly Subscription", presentationMode: .fullScreen)
        .fullScreenCover(isPresented: $subscriptions.showPaywall) {
            PaywallView(displayCloseButton: false)
                .edgesIgnoringSafeArea(.top)
        }
        
        
    }
}

#Preview {
    MainView(subscriptions: SubscriptionManager.shared)
}
