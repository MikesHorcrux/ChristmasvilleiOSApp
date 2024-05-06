//
//  SnowBackground.swift
//  secretelves
//
//  Created by Mike on 10/16/22.
//

import SwiftUI
import _SpriteKit_SwiftUI

struct SnowBackground: View {
    var scene: SKScene {
            let scene = SnowScene()
            scene.scaleMode = .resizeFill
            scene.backgroundColor = .clear
            return scene
        }

        var body: some View {
                  SpriteView(scene: scene, options: [.allowsTransparency])
                    .ignoresSafeArea()
                    .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
                    .background(Color("SnowBackground"))
        }
}

#Preview {
    ZStack {
        SnowBackground()
            .background(Color.black)
        Image("santa with deers_angle")
            .resizable()
            .aspectRatio(contentMode: .fit)
            .padding()
    }
}
