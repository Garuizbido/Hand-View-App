//
//  CVPixelBuffer+Extension.swift
//  Hand View
//
//  Created by Gabriel A. Ruiz Bido on 2/15/23.
//

import Foundation
import AVFoundation

extension CVPixelBuffer {
    
    func texture(withFormat pixelFormat: MTLPixelFormat, planeIndex: Int, addToCache cache: CVMetalTextureCache) -> MTLTexture? {
        
        let width = CVPixelBufferGetWidthOfPlane(self, planeIndex)
        let height = CVPixelBufferGetHeightOfPlane(self, planeIndex)
        
        print(height)
        
        var cvtexture: CVMetalTexture?
        CVMetalTextureCacheCreateTextureFromImage(nil, cache, self, nil, pixelFormat, width, height, planeIndex, &cvtexture)
        guard let texture = cvtexture else { return nil }
        return CVMetalTextureGetTexture(texture)
    }
    
}
