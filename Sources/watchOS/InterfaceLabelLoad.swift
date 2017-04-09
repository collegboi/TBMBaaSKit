//
//  InterfaceLabelLoad.swift
//  MBaaSKit
//
//  Created by Timothy Barnard on 09/04/2017.
//
//

import Foundation
import WatchKit

public protocol InterfaceLabelLoad {}

public extension InterfaceLabelLoad where Self: WKInterfaceLabel {
    
    /**
     - parameters:
     - className: put self
     - name: the name of the object instance
     
     */
    public mutating func setupLabel( className: WKInterfaceController, _ name: String = "" ) {
        
        self.setup(className: String(describing: type(of: className)), viewName: name)
    }
    
    private func setup( className: String, viewName : String ) {
        
        let dict = RCConfigManager.getObjectProperties(className: className, objectName: viewName)
        
        var fontName: String = ""
        var size : CGFloat = 0.0
        for (key, _) in dict {
            
            switch key {
            case "setText" where dict.tryConvert(forKey: key) != "":
                self.setText(dict.tryConvert(forKey: key))
                break
            case "backgroundColor" where dict.tryConvert(forKey: key) != "":
                 //backgroundColor = RCFileManager.readJSONColor(keyVal:  dict.tryConvert(forKey: key) )
                break
            case "fontName" where dict.tryConvert(forKey: key) != "":
                fontName = dict.tryConvert(forKey: key)
                break
            case "fontSize" where dict.tryConvert(forKey: key) != "":
                size = dict.tryConvert(forKey: key)
                break
            case "setTextColor" where dict.tryConvert(forKey: key) != "":
                self.setTextColor(RCFileManager.readJSONColor(keyVal: dict.tryConvert(forKey: key)))
                break
            case "isEnabled" where dict.tryConvert(forKey: key) != "":
                //self.isEnabled = dict.tryConvert(forKey: key)
                break
            case "isHidden" where dict.tryConvert(forKey: key) != "":
                self.setHidden(dict.tryConvert(forKey: key))
                break
            default: break
            }
        }
        
        if fontName != "" && size != 0.0 {
            let font = UIFont.systemFont(ofSize: size, weight: UIFontWeightMedium)
            let attrStr = NSAttributedString(string: fontName, attributes: [NSFontAttributeName: font])
            self.setAttributedText(attrStr)
        }
    }


}
    
