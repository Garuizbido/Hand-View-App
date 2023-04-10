//
//  QuadrantsView.swift
//  Hand View
//
//  Created by Jacqueline Hirsch on 3/25/23.
// this swift file is used to determine the depth of each area that the
// user is seeing. Each view is split into quadrants which is set by x and y.

import Foundation
import UIKit



class Quadrants {//points are 320x240
    
    private var bluetoothManager = BluetoothManager()
    
    //get the resolution of the phone screen h1920xw1140
    //user will hold phone vertically

    let height: Int = 1920
    let width: Int = 1140

    //set up the quadrants:
    //multiply gives the number of quadrants
    let x: Int = 3
    let y: Int = 3
    
    var quadrantAverage: [Int] = []
    
    //find depth of each dot (9 dots in each quadrant):
    //grab the data, the depth of each of the dots in each quadrant in calculated in camera manager and is in an array (mtl structure).
    
    //for each quadrant, find the average depth using the 9 dots (average value of the 9 dots):
    func averageDepths(){
        let numOfQuadrants: Int = x * y
        for i in 0...numOfQuadrants-1{
            //blah
        }
    }
    
    //Send to arduino
    func sendToBluetooth(){
        for i in quadrantAverage{
            bluetoothManager.writeValue(i)
        }
    }
}






