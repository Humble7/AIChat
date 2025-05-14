//
//  LogManager.swift
//  AIChat
//
//  Created by ChenZhen on 14/5/25.
//

import SwiftUI
import OSLog

actor LogSystem {
    let logger = Logger(subsystem: Bundle.main.bundleIdentifier!, category: "ConsoleLogger")

    func log(level: OSLogType, message: String) {
        logger.log(level: level, "\(message)")
    }

    nonisolated func log(level: LogType, message: String) {
        Task {
            await log(level: level.OSLogType, message: message)
        }
    }
}

enum LogType {
    /// User 'info' for informative tasks. These are not considered analytics, issues, or errors
    case info
    /// Default type for analytics
    case analytic
    /// Issues or errors that should not occur, but will not negatively affect the user experience
    case warning
    /// Issues or errors that negatively affect the user experience
    case severe

    var emoji: String {
        switch self {
        case .info:
            return "👋"
        case .analytic:
            return "📈"
        case .warning:
            return "⚠️"
        case .severe:
            return "🚨"
        }
    }

    var OSLogType: OSLogType {
        switch self {
        case .info:
            return .info
        case .analytic:
            return .default
        case .warning:
            return .error
        case .severe:
            return .fault
        }
    }
}

struct ConsoleService: LogService {

    let logger = LogSystem()

    private let printParameters: Bool

    init(printParameters: Bool = true) {
        self.printParameters = printParameters
    }

    func identifyUser(userId: String, name: String?, email: String?) {
        let string = """
📈 Identify User
    userId: \(userId)
    name: \(name ?? "unknown")
    email: \(email  ?? "unknown")
"""
        logger.log(level: LogType.info, message: string)
    }
    
    func addUserProperties(dict: [String: Any]) {
        var string = """
📈 Log User Properties
"""
        if printParameters {
            let sortedKeys = dict.keys.sorted()
            for key in sortedKeys {
                if let value = dict[key] {
                    string += "\n (key: \(key), value: \(value)"
                }
            }
        }

        logger.log(level: LogType.info, message: string)
    }
    
    func deleteUserProfile() {
        let string = """
📈 Delete User Profile
"""
        logger.log(level: LogType.info, message: string)
    }
    
    func trackEvent(event: any LoggableEvent) {
        var string = "\(event.type.emoji) \(event.eventName)"
        if printParameters, let parameters = event.parameters, !parameters.isEmpty {
            let sortedKeys = parameters.keys.sorted()
            for key in sortedKeys {
                if let value = parameters[key] {
                    string += "\n (key: \(key), value: \(value)"
                }
            }
        }
        logger.log(level: event.type, message: string)
    }
    
    func trackScreenEvent(event: any LoggableEvent) {
        trackEvent(event: event )
    }
}

@MainActor
@Observable
class LogManager {
    private let services: [LogService]

    init(services: [LogService] = []) {
        self.services = services
    }

    func identifyUser(userId: String, name: String?, email: String?) {
        for service in services {
            service.identifyUser(userId: userId, name: name, email: email)
        }
    }

    func addUserProperties(dict: [String: Any]) {
        for service in services {
            service.addUserProperties(dict: dict)
        }
    }

    func deleteUserProfile() {
        for service in services {
            service.deleteUserProfile()
        }
    }

    func trackEvent(event: LoggableEvent) {
        for service in services {
            service.trackEvent(event: event)
        }
    }

    func trackScreenEvent(event: LoggableEvent) {
        for service in services {
            service.trackScreenEvent(event: event)
        }
    }
}
