//
//  SnowScene.swift
//  SnowyThreads
//
//  Created by Alex Persian on 12/24/23.
//

import SpriteKit

class SnowScene: SKScene {

    let motionmanager: MotionManager
    let snowEmitterNode = SKEmitterNode(fileNamed: "Snow.sks")

    init(motionManager: MotionManager) {
        self.motionmanager = motionManager
        super.init(size: .zero)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func didMove(to view: SKView) {
        guard let snowEmitterNode = snowEmitterNode else { return }
        addChild(snowEmitterNode)
    }

    override func didChangeSize(_ oldSize: CGSize) {
        guard let snowEmitterNode = snowEmitterNode else { return }
        
        // The +20 makes the snow start slightly above the screen edge so it looks a bit more natural.
        snowEmitterNode.position = CGPoint(x: size.width / 2, y: size.height + 20)
        
        // Extending the particle range beyond the screen width means that when the device
        // is tilted the snow will enter from the edge. Again, a bit more natural look.
        snowEmitterNode.particlePositionRange = CGVector(dx: size.width * 2, dy: 0)
    }

    override func update(_ currentTime: TimeInterval) {
        // Changing the xAccel based on roll makes the particles respond to tilting.
        snowEmitterNode?.xAcceleration = motionmanager.roll * 100
    }
}
