//
//  Logger.swift
//  Market
//
//  Created by Beytullah Özer on 24.12.2021.
//

import Foundation

enum LoggerType {
    case info
    case error
    case warning
    
    var icon: String {
        switch self {
        case .info:
            return "ℹ️"
        case .error:
            return "❌"
        case .warning:
            return "⚠️"
        }
    }
}

struct Logger {
    
    static func log(type: LoggerType = .info, text: String, functionName: String = #function, line: Int = #line, file: String = #file) {
        print("\(type.icon) \(Date())" + "[\(file)][\(functionName)][\("\(line.toString)")] --> \(text)")
    }
}
