//
//  SceneDelegate.swift
//  StatLogger
//
//  Created by Trịnh Xuân Minh on 24/6/25.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

  var window: UIWindow?

  func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
    guard let windowScene = (scene as? UIWindowScene) else {
      return
    }
    
    let window = UIWindow(windowScene: windowScene)
    
    let navigationController = UINavigationController(rootViewController: HomeVC())
    navigationController.isNavigationBarHidden = true
    
    window.rootViewController = navigationController
    self.window = window
    window.makeKeyAndVisible()
  }
}

