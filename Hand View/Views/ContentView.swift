//
//  ContentView.swift
//  Hand View
//
//  Created by Gabriel A. Ruiz Bido on 2/15/23.
//Jackie

import SwiftUI
import MetalKit
import Metal

struct ContentView: View {
    
    @StateObject private var manager = CameraManager()
    
    @State private var maxDepth = Float(5.0)
    @State private var minDepth = Float(0.0)
    @State private var scaleMovement = Float(1.0)
    
    let maxRangeDepth = Float(15)
    let minRangeDepth = Float(0)
    
    var body: some View {
        DepthOverlay(manager: manager,
                     maxDepth: $maxDepth,
                     minDepth: $minDepth
        )
            .aspectRatio(calcAspect(orientation: viewOrientation, texture: manager.capturedData.depth), contentMode: .fill)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .previewDevice("iPhone 13 Pro")
    }
}
