//
//  CatLog.swift
//  Simple Logger in swift
//
//  Created by Akash kahalkar on 05/12/18.
//  Copyright © 2018 Akashka. All rights reserved.
//
//  https://gist.github.com/akashkahalkar/0507e0450c3fff667c9e482a22b0180d
//
import Foundation

enum LogEvent: String {
    case error = "‼️" // error
    case info = "ℹ️" // info
    case warning = "⚠️" // warning
}

/// Wrapping Swift.print() within DEBUG flag
///
/// - Note: *print()* might cause [security vulnerabilities](https://codifiedsecurity.com/mobile-app-security-testing-checklist-ios/)
///
/// - Parameter object: The object which is to be logged
///
func print(_ object: Any) {
    // Only allowing in DEBUG mode
    #if DEBUG
    Swift.print(object)
    #endif
}

class Log {
    
    private static var isLoggingEnabled: Bool {
        #if DEBUG
        return true
        #else
        return false
        #endif
    }
    
    // MARK: - Loging methods
    /// Logs error messages on console with prefix [‼️]
    ///
    /// - Parameters:
    ///   - object: Object or message to be logged
    ///   - type: type of events for log (error, info, debug, warning, verbose, severe)
    ///   - filename: File name from where loggin to be done
    ///   - line: Line number in file from where the logging is done
    ///   - column: Column number of the log message
    ///   - funcName: Name of the function from where the logging is done
    class func event(_ object: Any, _ type: LogEvent = .error, filename: String = #file, line: Int = #line, funcName: String = #function) {
        if isLoggingEnabled {
            print("\(type.rawValue)[\(sourceFileName(filePath: filename)): \(line)]: \(funcName): \(object)")
        }
    }
    
    private class func sourceFileName(filePath: String) -> String {
        let components = filePath.components(separatedBy: "/")
        return components.isEmpty ? "" : components.last!
    }
}
