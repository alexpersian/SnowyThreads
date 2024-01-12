//
//  ContentView.swift
//  SnowyThreads
//
//  Created by Alex Persian on 12/24/23.
//

import SwiftUI
import SpriteKit

struct ContentView: View {
    
    @ObservedObject var motionManager = MotionManager()
    
    var scene: SKScene {
        let scene = SnowScene(motionManager: motionManager)
        scene.scaleMode = .resizeFill
        scene.backgroundColor = .clear
        return scene
    }
    
    var body: some View {
        ZStack {
            Color
                .black
                .ignoresSafeArea()

            Image("pattern2")
                .resizable()
                .scaledToFit()
                .ignoresSafeArea()
                .offset(x: motionManager.roll * 100, y: motionManager.pitch * 100)

            Image("threads_logo_bg")
                .resizable()
                .scaledToFit()
                .ignoresSafeArea()

            SpriteView(scene: scene, options: [.allowsTransparency])
                .ignoresSafeArea()
                .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)

            Image("snow")
                .resizable()
                .scaledToFit()
                .position(x: UIScreen.main.bounds.maxX / 2, y: UIScreen.main.bounds.maxY - 45) // Hardcode asset position
                .ignoresSafeArea()
        }
        .onAppear {
            motionManager.startMotion()
        }
    }
}

#Preview {
    ContentView()
}
