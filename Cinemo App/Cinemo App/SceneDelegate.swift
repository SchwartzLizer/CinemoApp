//
//  SceneDelegate.swift
//  Cinemo App
//
//  Created by Tanatip Denduangchai on 10/13/23.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

  var window: UIWindow?


  func scene(_ scene: UIScene, willConnectTo _: UISceneSession, options _: UIScene.ConnectionOptions) {
    guard let windowScene = (scene as? UIWindowScene) else { return }
    if windowScene.traitCollection.userInterfaceStyle == .dark {
      StyleSheetManager.applyTheme(theme: .DarkMode)
    } else {
      StyleSheetManager.applyTheme(theme: .LightMode)
    }
  }

  func sceneDidDisconnect(_: UIScene) { }

  func sceneDidBecomeActive(_: UIScene) { }

  func sceneWillResignActive(_: UIScene) { }

  func sceneWillEnterForeground(_: UIScene) { }

  func sceneDidEnterBackground(_: UIScene) { }


}

