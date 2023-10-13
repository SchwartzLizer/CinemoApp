//
//  Configuration.swift
//  Template Project
//
//  Created by Tanatip Denduangchai on 10/13/23.
//

import Foundation

class Configuration {

  // MARK: Internal

  static let baseURL: String = {
    if let url = Configuration.getConfig().object(forKey: "base_url") as? String {
      return url
    } else {
      Logger.print("Error: base_url not found in Configuration.")
      return "https://default-url.com"
    }
  }()

  // MARK: Private

  private static func getConfig() -> NSDictionary {
    if
      let env = Bundle.main.object(forInfoDictionaryKey: "Configuration") as? String,
      let path = Bundle.main.path(forResource: "Configuration", ofType: "plist"),
      let configFile = NSDictionary(contentsOfFile: path),
      let config = configFile[env] as? NSDictionary
    {
      return config
    } else {
      Logger.print("Error: Configuration not found.")
      return NSDictionary()
    }
  }
}


