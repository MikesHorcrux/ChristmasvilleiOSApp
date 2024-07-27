//
//  SnowScene.swift
//  secretelves
//
//  Created by Mike on 10/16/22.
//



import Foundation
import SpriteKit

/// Custom SKScene to display falling snow using an SKEmitterNode
class SnowScene: SKScene {

    /// Emitter node for snow particles
    var snowEmitterNode: SKEmitterNode?

    /// Called when the scene is presented by a view
    override func didMove(to view: SKView) {
        // Load the snow emitter node from the .sks file
        if let node = SKEmitterNode(fileNamed: "snow.sks") {
            snowEmitterNode = node
            // Set the particle size for the snowflakes
            snowEmitterNode?.particleSize = CGSize(width: 50, height: 50)
            // Set the particle lifetime and its range
            snowEmitterNode?.particleLifetime = 4
            snowEmitterNode?.particleLifetimeRange = 4
            // Position the emitter node at the top center of the scene
            snowEmitterNode?.position = CGPoint(x: size.width / 2, y: size.height)
            // Set the range of particle positions to span the width of the scene
            snowEmitterNode?.particlePositionRange = CGVector(dx: size.width, dy: 0)
            // Add the emitter node to the scene
            addChild(snowEmitterNode!)
        }
    }

    /// Called when the size of the scene changes
    override func didChangeSize(_ oldSize: CGSize) {
        super.didChangeSize(oldSize)
        // Ensure the snow emitter node is not nil
        guard let snowEmitterNode = snowEmitterNode else { return }
        // Update the position of the emitter node to the top center of the new size
        snowEmitterNode.position = CGPoint(x: size.width / 2, y: size.height)
        // Update the particle position range to span the width of the new size
        snowEmitterNode.particlePositionRange = CGVector(dx: size.width, dy: 0)
    }
}

