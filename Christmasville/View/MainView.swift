//
//  MainView.swift
//  Christmasville
//
//  Created by Mike on 6/11/23.
//

import SwiftUI

struct MainView: View {
    @State private var selectedTab = 0
    var body: some View {
            #if os(iOS)
                NavigationStack {
                    CVTabView()
                }
            #elseif os(macOS) || targetEnvironment(macCatalyst)
            SplitMenuView()
            .frame(minWidth: 600, minHeight: 400)
            #endif
    }
}

#Preview {
    MainView()
}
