//
//  ConfigurationManager.swift
//  {{cookiecutter.app_name}}
//
//  Copyright © {{cookiecutter.company_name}}. All rights reserved.
//

import Foundation
import SnapKit
import CocoaLumberjack
import Kingfisher
import FLEX
import NSObject_Rx
import RxViewController
import RxOptional
import RxGesture
import SwifterSwift
import Hero

/**
 Use the Configuration.plist file to provide variables dependent on build configuration.
 An example would be the backend url, where for different build configurations you have different backend urls.
 */
class ConfigurationManager {

    enum Configuration: String {
        case debug = "Debug"
        case release = "Release"
        case production = "Production"
    }

    // MARK: Shared instance

    static let shared = ConfigurationManager()

    // MARK: Properties

    private let configurationKey = "Configuration"
    private let configurationDictionaryName = "Configuration"
    private let backendUrlKey = "backendUrl"

    let activeConfiguration: Configuration
    private let activeConfigurationDictionary: NSDictionary

    // MARK: Lifecycle

    init () {
        let bundle = Bundle(for: ConfigurationManager.self)
        guard let rawConfiguration = bundle.object(forInfoDictionaryKey: configurationKey) as? String,
            let activeConfiguration = Configuration(rawValue: rawConfiguration),
            let configurationDictionaryPath = bundle.path(forResource: configurationDictionaryName, ofType: "plist"),
            let configurationDictionary = NSDictionary(contentsOfFile: configurationDictionaryPath),
            let activeEnvironmentDictionary = configurationDictionary[activeConfiguration.rawValue] as? NSDictionary
            else {
                fatalError("Configuration Error")

        }
        self.activeConfiguration = activeConfiguration
        self.activeConfigurationDictionary = activeEnvironmentDictionary
    }

    // MARK: Methods

    private func getActiveVariableValue<V>(forKey key: String) -> V {
        guard let value = activeConfigurationDictionary[key] as?  V else {
            fatalError("No value satysfying requirements")
        }
        return value
    }

    func isRunning(in configuration: Configuration) -> Bool {
        return activeConfiguration == configuration
    }

    func getBackendUrl() -> URL {
        let backendUrlString: String = getActiveVariableValue(forKey: backendUrlKey)
        guard let backendUrl = URL(string: backendUrlString) else {
            fatalError("Backend URL missing")
        }
        return backendUrl
    }
    
    func setupLibs(with window: UIWindow? = nil) {
        let libsManager = ConfigurationManager.shared
        libsManager.setupCocoaLumberjack()
        libsManager.setupKingfisher()
        libsManager.setupFLEX()
    }
    
    func setupKingfisher() {
        // Set maximum disk cache size for default cache. Default value is 0, which means no limit.
        ImageCache.default.maxDiskCacheSize = UInt(500 * 1024 * 1024) // 500 MB
        
        // Set longest time duration of the cache being stored in disk. Default value is 1 week
        ImageCache.default.maxCachePeriodInSecond = TimeInterval(60 * 60 * 24 * 7) // 1 week
        
        // Set timeout duration for default image downloader. Default value is 15 sec.
        ImageDownloader.default.downloadTimeout = 15.0 // 15 sec
    }
    
    func setupCocoaLumberjack() {
        DDLog.add(DDTTYLogger.sharedInstance) // TTY = Xcode console
        //        DDLog.add(DDASLLogger.sharedInstance) // ASL = Apple System Logs
        
        let fileLogger: DDFileLogger = DDFileLogger() // File Logger
        fileLogger.rollingFrequency = TimeInterval(60*60*24)  // 24 hours
        fileLogger.logFileManager.maximumNumberOfLogFiles = 7
        DDLog.add(fileLogger)
    }
    func setupFLEX() {
        FLEXManager.shared().isNetworkDebuggingEnabled = true
    }
}

extension ConfigurationManager {
    
    func showFlex() {
        FLEXManager.shared().showExplorer()
    }
    
    func removeKingfisherCache(completion handler: (() -> Void)?) {
        ImageCache.default.clearMemoryCache()
        ImageCache.default.clearDiskCache {
            handler?()
        }
    }
}
