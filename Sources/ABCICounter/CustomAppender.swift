//
//  CustomAppender.swift
//  ABCISwift
//

import Foundation
import Core

public struct CustomAppender : LogAppender {
    public let name: String?
    public let levels: Logger.Level
    
    public init(_ name: String? = nil, levels: Logger.Level = .all) {
        self.name = name
        self.levels = levels
    }
    
    public func append(event: Logger.Event) {
        var logMessage = ""
        
        let level = event.level.description
        
        logMessage += level == "" ? "" : "[" + level + "]"
        let date = Date(timeIntervalSince1970: TimeInterval(event.timestamp))
        let dateFormatter = DateFormatter()
        dateFormatter.locale = NSLocale.current
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss.SSSS"
        let strDate = dateFormatter.string(from: date)
        logMessage += "[\(strDate)]"
        //logMessage += "[" + event.locationInfo.description + "]"
        
        if let message = event.message {
            logMessage += ":" + String(describing: message)
        }
        
        if let name = self.name {
            logMessage += "[\(name)]"
        }
        
        if let error = event.error {
            logMessage += ":" + String(describing: error)
        }
        
        print(logMessage)
    }
}
