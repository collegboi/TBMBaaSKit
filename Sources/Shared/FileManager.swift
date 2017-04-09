//
//  RCFileManager.swift
//  Remote Config
//
//  Created by Timothy Barnard on 29/10/2016.
//  Copyright © 2016 Timothy Barnard. All rights reserved.
//

import Foundation

#if os(iOS)
    import UIKit
#elseif os(watchOS)
    import WatchKit
#endif

enum RCFile : String {
    case saveConfigJSON = "configFile1.json"
    case readConfigJSON = "configFile.json"
    case saveLangJSON = "langFile1.json"
    case readLangJSON = "langFile.json"
}

public enum RCFileType {
    case config
    case language
}


class RCFileManager {
    
    class func readPlistString( value: String, _ defaultStr: String = "") -> String {
        var defaultURL = defaultStr
        if let path = Bundle.main.path(forResource: "Info", ofType: "plist"), let dict = NSDictionary(contentsOfFile: path) as? [String: AnyObject] {
            
            guard let valueStr = dict[value] as? String else {
                return defaultURL
            }
            
            defaultURL = valueStr
        }
        return defaultURL
    }
    
    class func readJSONFile( fileName: RCFile ) -> Data? {
        
        var returnData : Data?
        
        let file = fileName.rawValue
        
        if let dir = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true).first,
            let path = NSURL(fileURLWithPath: dir).appendingPathComponent(file) {
            
            returnData = NSData(contentsOf: path) as Data?
        }
        return returnData
    }
    
    class func getJSONDict( parseKey : String, keyVal : String ) -> [String:AnyObject] {
        
        var returnStr = [String:AnyObject]()
        
        guard let jsonData = RCFileManager.readJSONFile(fileName: .readConfigJSON) else {
            return returnStr
        }
        
        do {
            
            let parsedData = try JSONSerialization.jsonObject(with: jsonData, options: .allowFragments) as! [String:AnyObject]
            
            for( value ) in parsedData["controllers"] as! NSArray {
                
                guard let dict = value as? [String:Any] else {
                    break
                }
                
                guard let controllerName = dict["name"] as? String else {
                    break
                }
                //print(value)
                let trimmedString = parseKey.trimmingCharacters(in: .whitespaces)
                //print(controllerName)
                //print(trimmedString)
                
                if controllerName.contains(trimmedString) {
                    
                    //print(dict)
                    for ( object ) in dict["objectsList"] as! NSArray {
                        
                        if let newobject = object as? [String: AnyObject ] {
                            
                            guard let objectName = newobject["objectName"] as? String else {
                                break
                            }
                            //print(objectName)
                            //print(keyVal)
                            if objectName.contains(keyVal) {
                                
                                guard let propertiesList = newobject["objectProperties"] as? [String:AnyObject] else {
                                    break
                                }
                                //print(dict)
                                returnStr = propertiesList
                            }
                            
                        }
                    }
                }
                
            }
            
        } catch let error as NSError {
            print(error)
        }
        return returnStr
    }
    
    class func getJSONClassProperties( parseKey : String ) -> [String:AnyObject] {
        
        var returnStr = [String:AnyObject]()
        
        guard let jsonData = RCFileManager.readJSONFile(fileName: .readConfigJSON) else {
            return returnStr
        }
        
        do {
            
            let parsedData = try JSONSerialization.jsonObject(with: jsonData, options: .allowFragments) as! [String:AnyObject]
            
            for( value ) in parsedData["controllers"] as! NSArray {
                
                guard let dict = value as? [String:Any] else {
                    break
                }
                
                guard let controllerName = dict["name"] as? String else {
                    break
                }
                
                //print(value)
                let trimmedString = parseKey.trimmingCharacters(in: .whitespaces)
                //print(controllerName)
                //print(trimmedString)
                
                if controllerName.contains(trimmedString) {
                    
                    
                    guard let propertiesList = dict["classProperties"] as? [String:AnyObject] else {
                        break
                    }
                    //print(dict)
                    returnStr = propertiesList
                    break
                }
            }
            
        } catch let error as NSError {
            print(error)
        }
        return returnStr
    }

    
    
    class func readJSONColor( keyVal : String ) -> UIColor? {
        
        var returnColor : UIColor?
        
        guard let jsonData = RCFileManager.readJSONFile(fileName: .readConfigJSON) else {
            return returnColor
        }
        
        do {
            let parsedData = try JSONSerialization.jsonObject(with: jsonData, options: .allowFragments) as! [String:Any]
            
            for ( color ) in parsedData["colors"] as! NSArray {
                
                guard let nextColor = color as? [String:Any] else {
                    break
                }
                guard let colorName = nextColor["name"] as? String else {
                    break
                }
                if colorName == keyVal {
                    
                    let red: Float = nextColor.tryConvert(forKey: "red")
                    
                    let green: Float = nextColor.tryConvert(forKey: "green")
                    
                    let blue: Float = nextColor.tryConvert(forKey: "blue")
                    
                    let alpha: Float = nextColor.tryConvert(forKey: "alpha")
                    
                    //print(alpha)
                    returnColor =  UIColor(red: CGFloat(red)/255, green: CGFloat(green)/255.0, blue: CGFloat(blue)/255.0, alpha: CGFloat(alpha))
                    break
                }
            }
            
        } catch let error as NSError {
            print(error)
        }
        return returnColor
    }
    
    
    class func readConfigVersion(_ key: String) -> String? {
        
        var returnStr: String?
        
        guard let jsonData = RCFileManager.readJSONFile(fileName: .readConfigJSON) else {
            return returnStr
        }
        
        do {
            let parsedData = try JSONSerialization.jsonObject(with: jsonData, options: .allowFragments) as! [String:Any]
            
            //guard let configObject = parsedData["config"] as? [String:String]  else {
            //    return returnStr
            //}
            
            guard let valueName = parsedData[key] as? String else {
                return returnStr
            }
            
            returnStr = valueName
            
        } catch let error as NSError {
            print(error)
        }
        
        
        return returnStr
    }
    
    
    class func readJSONMainSettings( keyName: String ) -> String? {
        
        var returnStr: String?
        
        guard let jsonData = RCFileManager.readJSONFile(fileName: .readConfigJSON) else {
            return returnStr
        }
        
        do {
            let parsedData = try JSONSerialization.jsonObject(with: jsonData, options: .allowFragments) as! [String:Any]
            
            guard let translationList = parsedData["mainSettings"] as? [String:String]  else {
                return returnStr
            }
            
            guard let valueName = translationList[keyName] else {
                return returnStr
            }
            
            returnStr = valueName
            
        } catch let error as NSError {
            print(error)
        }
        
        
        return returnStr
    }
    
    class func readJSONThemesList() -> [String]? {
        
        var returnStr: [String]?
        
        guard let jsonData = RCFileManager.readJSONFile(fileName: .readConfigJSON) else {
            return returnStr
        }
        
        do {
            let parsedData = try JSONSerialization.jsonObject(with: jsonData, options: .allowFragments) as! [String:Any]
            
            guard let translationList = parsedData["themes"] as? [String]  else {
                return returnStr
            }
            
            returnStr = translationList
            
        } catch let error as NSError {
            print(error)
        }
        
        
        return returnStr
    }

    
    class func readJSONLanuageList() -> [String]? {
        
        var returnStr: [String]?
        
        guard let jsonData = RCFileManager.readJSONFile(fileName: .readConfigJSON) else {
            return returnStr
        }
        
        do {
            let parsedData = try JSONSerialization.jsonObject(with: jsonData, options: .allowFragments) as! [String:Any]
            
            guard let translationList = parsedData["languagesList"] as? [String]  else {
                return returnStr
            }
            
            returnStr = translationList
            
        } catch let error as NSError {
            print(error)
        }
        
        
        return returnStr
    }
    
    
    class func readJSONTranslation( keyName: String ) -> String? {
        
        var returnStr: String?
        
        guard let jsonData = RCFileManager.readJSONFile(fileName: .readLangJSON) else {
            return returnStr
        }
        
        do {
            let parsedData = try JSONSerialization.jsonObject(with: jsonData, options: .allowFragments) as! [String:Any]
            
            guard let translationList = parsedData["translationList"] as? [String:String]  else {
                return returnStr
            }
            
            guard let valueName = translationList[keyName] else {
                return returnStr
            }
            
            returnStr = valueName
            
        } catch let error as NSError {
            print(error)
        }
        
        
        return returnStr
    }
    
    class func deleteJSONFileName( fileName: String ) -> Bool {
        
        if checkFilesExists(fileName: fileName) {
            
            let path = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as String
            let url = NSURL(fileURLWithPath: path)
            let filePath = url.appendingPathComponent(fileName)?.path
            let fileManager = FileManager.default
            
            do {
                
                try fileManager.removeItem(atPath: filePath!)
            } catch {
                print("Could not clear temp folder: \(error)")
                return false
            }
        }
        return true
    }
    
    class func checkFilesExists( fileName: String) -> Bool {
        
        //var fileFound = false
        
        let path = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as String
        let url = NSURL(fileURLWithPath: path)
        let filePath = url.appendingPathComponent(fileName)?.path
        let fileManager = FileManager.default
        if fileManager.fileExists(atPath: filePath!) {
            return true
        } else {
            return false
        }
        
        /*if let dir = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true).first,
         let _ = NSURL(fileURLWithPath: dir).appendingPathComponent(fileName) {
         
         fileFound = true
         }
         
         let documentsUrl =  FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
         print(documentsUrl)
         
         let path = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
         let documentDirectory = URL(fileURLWithPath: path)
         let originPath = documentDirectory.appendingPathComponent(fileName)
         
         do {
         
         let directoryContents = try FileManager.default.contentsOfDirectory(at: documentsUrl, includingPropertiesForKeys: nil, options: [])
         
         let jsonFiles = directoryContents.filter{ $0.pathExtension == "json" }
         
         
         //let filePaths = try fileManager.contentsOfDirectory(atPath: tempFolderPath)
         for filePath in jsonFiles {
         print("list",filePath)
         print("find", originPath)
         if filePath == originPath {
         fileFound = true
         break
         } else {
         fileFound = false
         }
         }
         } catch {
         print("Could not clear temp folder: \(error)")
         }*/
        //return fileFound
    }
    
    
    
    class func changeJSONFileName(oldName: String, newName: String) {
        
        if deleteJSONFileName(fileName: newName) {
            
            do {
                let path = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
                let documentDirectory = URL(fileURLWithPath: path)
                let originPath = documentDirectory.appendingPathComponent(oldName)
                let destinationPath = documentDirectory.appendingPathComponent(newName)
                try FileManager.default.moveItem(at: originPath, to: destinationPath)
            } catch {
                print(error)
            }
        }
    }
    
    class func updateJSONFile( fileType : RCFileType ) {
        
        switch fileType {
        case .language:
            
            self.changeJSONFileName(oldName: RCFile.saveLangJSON.rawValue, newName: RCFile.readLangJSON.rawValue)
            
        default:
            self.changeJSONFileName(oldName: RCFile.saveConfigJSON.rawValue, newName: RCFile.readConfigJSON.rawValue)
        }
    }

    
    class func writeJSONFile( jsonData : NSData, fileType : RCFileType ) {
        
        var fileName: String = ""
        
        switch fileType {
        case .language:
            //if RCFileManager.checkFilesExists(fileName: RCFile.readLangJSON.rawValue) {
            //    fileName = RCFile.saveLangJSON.rawValue
            //} else {
            fileName = RCFile.saveLangJSON.rawValue
        //}
        default:
            //if RCFileManager.checkFilesExists(fileName: RCFile.readConfigJSON.rawValue) {
            //    fileName = RCFile.saveConfigJSON.rawValue
            //} else {
            fileName = RCFile.saveConfigJSON.rawValue
            //}
        }
        
        
        if let dir = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true).first,
            let path = NSURL(fileURLWithPath: dir).appendingPathComponent(fileName) {
            //print("WritePath", path)
            
            do {
                try jsonData.write(to: path, options: .noFileProtection) //text.write(to: path, atomically: false, encoding: String.Encoding.utf8)
            }
            catch {/* error handling here */}
        }
    }
}
