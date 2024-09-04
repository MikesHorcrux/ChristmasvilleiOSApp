//
//  SantasWorkshop.swift
//  Christmasville
//
//  Created by Mike  Van Amburg on 6/4/24.
//

import SwiftUI
import SwiftData

/// Main view representing Santa's Workshop, displaying a list of giftees.
struct SantasWorkshop: View {
    @Query var giftees: [Giftee]
    
    @State var showChat: Bool = false
    
    var body: some View {
        NavigationStack(){
            if giftees.isEmpty {
                emptyStateView
            } else {
                contentStateView
            }
        }
    }
    
    /// View displayed when there are no giftees.
    private var emptyStateView: some View {
        VStack {
            SWEmptyPage()
        }
        .toolbar {
            ToolbarItem(placement: .automatic) {
                NavigationLink {
                    CreateGifteeView()
                } label: {
                    HStack {
                        Image(systemName: "plus")
                        Image("Sleigh - 2")
                    }
                }
                .buttonStyle(BorderedProminentButtonStyle())
            }
            
        }
    }
    
    /// View displayed when there are giftees.
    private var contentStateView: some View {
        List(){
            ForEach(giftees) { giftee in
                NavigationLink(value: giftee) {
                    GifteeCard(giftee: giftee)
                    
                }
            }
        }
        .snowBackground()
        .toolbar {
            ToolbarItem(placement: .automatic) {
                NavigationLink {
                    CreateGifteeView()
                } label: {
                    HStack {
                        Image(systemName: "plus")
                        Image("Sleigh - 2")
                    }
                }
                .buttonStyle(BorderedProminentButtonStyle())
            }
            
            ToolbarItem(placement: .topBarLeading) {
                Button() {
                    showChat.toggle()
                } label: {
                    HStack {
                        Image("Sock - 2")
                        Text("SC. Workshop")
                    }
                }
                .buttonStyle(BorderedProminentButtonStyle())
                
            }
            
        }
        .navigationDestination(for: Giftee.self) { giftee in
            GifteeView(giftee: giftee)
        }
        //MARK: Sheets
        .sheet(isPresented: $showChat) {
            ChatView(bot: .santasWorkshop, showCapsule: true)
        }
    }
}

#Preview {
    SantasWorkshop()
}
