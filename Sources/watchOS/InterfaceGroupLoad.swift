//
//  InterfaceGroupLoad.swift
//  MBaaSKit
//
//  Created by Timothy Barnard on 09/04/2017.
//
//

import Foundation
import WatchKit

public protocol InterfaceGroupLoad {}

public extension InterfaceGroupLoad where Self: WKInterfaceGroup {
    
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
            case "setBackgroundImageNamed" where dict.tryConvert(forKey: key) != "":
                self.setBackgroundImageNamed(dict.tryConvert(forKey: "setBackgroundImageNamed"))
                break
            case "setBackgroundColor" where dict.tryConvert(forKey: key) != "":
                self.setBackgroundColor(RCConfigManager.getColor(name: dict.tryConvert(forKey: "setBackgroundColor")))
                break
            case "setCornerRadius" where dict.tryConvert(forKey: key) != "":
                self.setCornerRadius(dict.tryConvert(forKey: "setCornerRadius"))
            default: break
            }
        }
    }
}
