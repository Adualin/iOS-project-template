//
//  LogManager.swift
//  {{cookiecutter.app_name}}
//
//  Copyright © {{cookiecutter.company_name}}. All rights reserved.
//

import Foundation
import CocoaLumberjack

public func logDebug(_ message: @autoclosure () -> String) {
    DDLogDebug(message)
}

public func logError(_ message: @autoclosure () -> String) {
    DDLogError(message)
}

public func logInfo(_ message: @autoclosure () -> String) {
    DDLogInfo(message)
}

public func logVerbose(_ message: @autoclosure () -> String) {
    DDLogVerbose(message)
}

public func logWarn(_ message: @autoclosure () -> String) {
    DDLogWarn(message)
}
