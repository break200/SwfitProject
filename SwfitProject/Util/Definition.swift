//
//  Definition.swift
//  SwfitProject
//
//  Created by mograine on 2021/12/08.
//


import UIKit
import CoreLocation

class Definition: NSObject {
    
    #if DEBUG
    static let BUCKETNAME   = "prdfishingtags"
    static let FSBRICDEBUG   = false
    #else
    static let BUCKETNAME   = "prdfishingtags"
    static let FSBRICDEBUG   = true
    #endif
    
    static let BASICPOSITION = CLLocation(latitude: 32.323232323, longitude: 1426.958966)

    static let WEIGHT = "WEIGHT";
    
    
}
