//
//  MotionManager.swift
//  SnowyThreads
//
//  Created by Alex Persian on 12/24/23.
//

import CoreMotion

class MotionManager: ObservableObject {
    
    let motionManager = CMMotionManager()
    let motionQueue = OperationQueue() // Motion updates get their own queue
    
    @Published var pitch: Double = 0.0
    @Published var roll: Double = 0.0
    
    func startMotion() {
        guard motionManager.isDeviceMotionAvailable else {
            print("ERR: Motion not available")
            return
        }

        // If this number is too high then visuals will be choppy
        motionManager.deviceMotionUpdateInterval = 0.01
        
        motionManager.startDeviceMotionUpdates(to: motionQueue) { data, error in
            guard error == nil, let data = data else {
                print("ERR: Data not available")
                return
            }

            // These properties connect to UI so need to be updated on main thread
            DispatchQueue.main.async { [weak self] in
                self?.pitch = data.attitude.pitch
                self?.roll = data.attitude.roll
            }
        }
    }

    func stopMotion() {
        motionManager.stopDeviceMotionUpdates()
    }
}
