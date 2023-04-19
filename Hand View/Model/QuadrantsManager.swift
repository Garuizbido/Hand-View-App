//
//  QuadrantsView.swift
//  Hand View
//
//  Created by Jacqueline Hirsch on 3/25/23.
// this swift file is used to determine the depth of each area that the
// user is seeing. Each view is split into quadrants which is set by x and y.

import Foundation
import UIKit
import CoreGraphics

class QuadrantManager {//points are 320x240
    
    private var bluetoothManager = BluetoothManager()
    
    //get the resolution of the phone screen h1920xw1140
    //user will hold phone vertically

    let height: Int = 1440
    let width: Int = 1920 
    
    func colorOfPixel(in texture: MTLTexture, at point: CGPoint) -> CGFloat {
        let width = texture.width
        let height = texture.height

        // Calculate the row and column of the pixel
        let column = Int(point.x * CGFloat(width))
        let row = Int(point.y * CGFloat(height))

        // Calculate the index of the pixel in the data array
        let bytesPerPixel = 4 // RGBA
        let bytesPerRow = bytesPerPixel * width

        // Get the pixel data from the texture
        var pixelData = [UInt8](repeating: 0, count: bytesPerPixel)
        let region = MTLRegionMake2D(column, row, 1, 1)
        texture.getBytes(&pixelData, bytesPerRow: bytesPerRow, from: region, mipmapLevel: 0)

        // Extract the color information from the pixel data
        let red = CGFloat(pixelData[0])/255
        
        return red
    }
    
    func test(in texture: MTLTexture){
        var quadrantAverage: [Int] = []
        for i in 1...4{
            for j in 1...4{
                let x: Double = Double(i)/Double(5)
                let y: Double = Double(j)/Double(5)
                let color = colorOfPixel(in: texture, at: CGPoint(x: x, y: y))
                print(color)
                if color < 0.50{
                    quadrantAverage.append(0)
                }
                else if color < 0.70{
                    quadrantAverage.append(1)
                }
                else{
                    quadrantAverage.append(2)
                }
            }
        }
        print(quadrantAverage)
        //bluetoothManager.writeValue(i)
    }
}







