//
//  ContentView.swift
//  Hand View
//
//  Created by Gabriel A. Ruiz Bido on 2/15/23.
//

import SwiftUI
import MetalKit
import Metal
import RealityKit
import ARKit

class DepthMapViewController: UIViewController, ARSessionDelegate {
    
    @IBOutlet var arView: ARView!
    @IBOutlet weak var imageView: UIImageView!
    
    var orientation: UIInterfaceOrientation {
        guard let orientation = UIApplication.shared.windows.first?.windowScene?.interfaceOrientation else {
            fatalError()
        }
        return orientation
    }
    @IBOutlet weak var imageViewHeight: NSLayoutConstraint!
    lazy var imageViewSize: CGSize = {
        CGSize(width: view.bounds.size.width, height: imageViewHeight.constant)
    }()

    override func viewDidLoad() {
        func buildConfigure() -> ARWorldTrackingConfiguration {
            let configuration = ARWorldTrackingConfiguration()

            configuration.environmentTexturing = .automatic
            if type(of: configuration).supportsFrameSemantics(.sceneDepth) {
               configuration.frameSemantics = .sceneDepth
            }

            return configuration
        }
        super.viewDidLoad()
        
        arView.session.delegate = self
        let configuration = buildConfigure()
        arView.session.run(configuration)
    }

    func session(_ session: ARSession, didUpdate frame: ARFrame) {
        
        guard let depthMap = frame.sceneDepth?.depthMap else { return }
        print(depthMap)
    }
}

struct ContentView: View {
    
    @StateObject private var cameraManager = CameraManager()
    @State private var quadrantManager = QuadrantManager()
    
    
    @State private var maxDepth = Float(5.0)
    @State private var minDepth = Float(0.0)
    @State private var scaleMovement = Float(1.0)
    
    
    
    let maxRangeDepth = Float(15)
    let minRangeDepth = Float(0)
    
    var body: some View {
        VStack {
            DepthOverlay(manager: cameraManager,
                         maxDepth: $maxDepth,
                         minDepth: $minDepth
            )
            .aspectRatio(calcAspect(orientation: viewOrientation, texture: cameraManager.capturedData.depth), contentMode: .fit)
            .onTapGesture {
                if let texture = cameraManager.capturedData.colorY{
                    let color = colorOfPixel(in: texture, at: CGPoint(x: 0.5, y: 0.5))
                    var redComponent: CGFloat = 0.0
                    var greenComponent: CGFloat = 0.0
                    var blueComponent: CGFloat = 0.0
                    var alphaComponent: CGFloat = 0.0
                    color.getRed(&redComponent, green: &greenComponent, blue: &blueComponent, alpha: &alphaComponent)
                }
            }
        }
    }
}

func colorOfPixel(in texture: MTLTexture, at point: CGPoint) -> UIColor {
    let width = texture.width
    let height = texture.height

    // Calculate the row and column of the pixel
    let column = Int(point.x * CGFloat(width))
    let row = Int(point.y * CGFloat(height))
    
    print(row)
    print(column)

    // Calculate the index of the pixel in the data array
    let bytesPerPixel = 4 // RGBA
    let bytesPerRow = bytesPerPixel * width

    // Get the pixel data from the texture
    var pixelData = [UInt8](repeating: 0, count: bytesPerPixel)
    let region = MTLRegionMake2D(column, row, 1, 1)
    texture.getBytes(&pixelData, bytesPerRow: bytesPerRow, from: region, mipmapLevel: 0)

    // Extract the color information from the pixel data
    let red = CGFloat(pixelData[0])/255
    let green = CGFloat(pixelData[1])/255
    let blue = CGFloat(pixelData[2])/255
    
    print("Red component: \(red)")

    return  UIColor(red: red, green: green, blue: blue, alpha: 1.0)
}


/*func getColorAtPixel(view: UIView, x: Int, y: Int) -> UIColor {
    let pixel = UnsafeMutablePointer<UInt8>.allocate(capacity: 4)
    let colorSpace = CGColorSpaceCreateDeviceRGB()
    let bitmapInfo = CGBitmapInfo(rawValue: CGImageAlphaInfo.premultipliedLast.rawValue)
    let context = CGContext(data: pixel, width: 1, height: 1, bitsPerComponent: 8, bytesPerRow: 4, space: colorSpace, bitmapInfo: bitmapInfo.rawValue)!
    context.translateBy(x: CGFloat(-x), y: CGFloat(-y))
    view.layer.render(in: context)
    let color = UIColor(red: CGFloat(pixel[0]) / 255.0, green: CGFloat(pixel[1]) / 255.0, blue: CGFloat(pixel[2]) / 255.0, alpha: CGFloat(pixel[3]) / 255.0)
    pixel.deallocate()
    return color
}



//height 844
//width 390
 */
