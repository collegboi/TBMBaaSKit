//
//  InterfaceImageLoad.swift
//  MBaaSKit
//
//  Created by Timothy Barnard on 09/04/2017.
//
//

import Foundation
import WatchKit

public protocol InterfaceImageLoad {}

public extension InterfaceImageLoad where Self: WKInterfaceImage {
    
    /**
     - parameters:
     - className: put self
     - name: the name of the object instance
     
     */
    public mutating func setupTable( className: WKInterfaceController, _ name: String = "" ) {
        
        self.setup(className: String(describing: type(of: className)), viewName: name)
    }
    
    private func setup( className: String, viewName : String ) {
        
        let dict = RCConfigManager.getObjectProperties(className: className, objectName: viewName)
        
        for (key, _) in dict {
            switch key {
            case "setTintColor" where dict.tryConvert(forKey: key) != "":
                self.setTintColor(RCConfigManager.getColor(name: dict.tryConvert(forKey: "setTintColor")))
                break
            case "setImageNamed" where dict.tryConvert(forKey: key) != "":
                self.setImageNamed(dict.tryConvert(forKey: "setImageNamed"))
            default: break
            }
        }
    }
}
