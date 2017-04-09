//
//  InterfaceSeparatorLoad.swift
//  MBaaSKit
//
//  Created by Timothy Barnard on 09/04/2017.
//
//

import Foundation
import WatchKit

public protocol InterfaceSeparatorLoad {}

public extension InterfaceSeparatorLoad where Self: WKInterfaceSeparator {
    
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
                case "setColor" where dict.tryConvert(forKey: key) != "":
                    self.setColor(RCConfigManager.getColor(name: dict.tryConvert(forKey: "setColor")))
                break
            default: break
            }
        }
    }
}
