//
//  OnboardingView.swift
//  Christmasville
//
//  Created by Mike  Van Amburg on 9/1/24.
//


import SwiftUI

struct OnboardingView: View {
    @State private var currentPage = 0
    @Binding var hasOnboarded: Bool
    var body: some View {
        VStack {
            TabView(selection: $currentPage) {
                // Page 1: Introduction
                OnboardingPageView(imageName:"santa with Christmas tree", title: "Welcome to Christmasville!", description: "Ho Ho Ho! I'm Santa Claus, and I'm thrilled to welcome you to Christmasville, where the magic of Christmas is alive all year round.")
                    .tag(0)
                
                // Page 2: Discover Christmas Lights
                OnboardingPageView(imageName: "LightsScreenshot", title: "Discover Christmas Lights", description: "I love seeing all the beautiful Christmas lights around the world. Explore and add your favorite displays in Christmasville!")
                    .tag(1)
                
                // Page 3: Cook with Mrs. Claus
                OnboardingPageView(imageName: "kitchenScreenshot", title: "Cook with Mrs. Claus", description: "Mrs. Claus has some secret recipes to share! Join her in the kitchen and whip up some festive treats.")
                    .tag(2)
                
                // Page 4: Manage Your Gift List
                OnboardingPageView(imageName: "SLScreenShot", title: "Manage Your Gift List", description: "Keep track of all your holiday gifts just like I do! Organize and plan the perfect Christmas for your loved ones.")
                    .tag(3)
                
                // Page 5: Chat with Mrs. Claus
                OnboardingPageView(imageName: "mcScreenshot", title: "Chat with Mrs. Claus and More!", description: "Mrs. Claus loves to chat! Get her advice on recipes, holiday decorations, and more. She's always here to help!")
                    .tag(4)
                
                // Page 6: Final Call to Action
                OnboardingPageView(imageName: "santa sleds with deers", title: "Ready to Join Christmasville?", description: "It's time to start your magical journey! Let's spread the Christmas cheer together.")
                    .tag(5)
            }
            .tabViewStyle(PageTabViewStyle())
            
            // Navigation controls
            HStack {
                if currentPage > 0 {
                    Button(action: {
                        withAnimation {
                            currentPage -= 1
                        }
                    }) {
                        Text("Back")
                            .font(.headline)
                            .padding()
                    }
                }
                
                Spacer()
                
                if currentPage < 5 {
                    Button(action: {
                        withAnimation {
                            currentPage += 1
                        }
                    }) {
                        Text("Next")
                            .font(.headline)
                            .padding()
                    }
                } else {
                    Button(action: {
                        hasOnboarded = true
                    }) {
                        Text("Continue")
                    }
                    .buttonStyle(BorderedProminentButtonStyle())
                }
            }
            //.padding()
        }
        .snowBackground()
    }
}

struct OnboardingPageView: View {
    var imageName: String
    var title: String
    var description: String
    
    var body: some View {
        VStack(spacing: 20) {
            Image(imageName)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(maxHeight: 800)
            
            Text(title)
                .font(.title)
                .bold()
                .multilineTextAlignment(.center)
                .foregroundColor(.white)
            
            Text(description)
                .font(.body)
                .multilineTextAlignment(.center)
                .padding(.horizontal)
                .foregroundColor(.white)
        }
        .padding()
        .padding(.bottom, 40)
    }
}

struct OnboardingView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingView(hasOnboarded: .constant(false))
    }
}
