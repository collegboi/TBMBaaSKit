//
//  InterfaceTableLoad.swift
//  MBaaSKit
//
//  Created by Timothy Barnard on 09/04/2017.
//
//

import Foundation
import WatchKit

public protocol InterfaceTableLoad {}

public extension InterfaceTableLoad where Self: WKInterfaceTable {
    
    
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
        
        for (key, value) in dict {
            switch key {
            case "isScrollEnabled" where dict.tryConvert(forKey: key) != "":
                self.setHidden(((value as! Int)  == 1) ? true : false)
                break
            case "setHidden" where dict.tryConvert(forKey: key) != "":
                self.setHidden(((value as! Int)  == 1) ? true : false)
            case "allowsSelection" where dict.tryConvert(forKey: key) != "":
                //self.select = ((value as! Int)  == 1) ? true : false
                break
            case "backgroundColor" where dict.tryConvert(forKey: key) != "":
                
                //self.backgroundColor = RCConfigManager.getColor(name: dict.tryConvert(forKey: "backgroundColor"))
                break
            default: break
            }
        }
    }

    
}
