//
//  SceneDelegate.swift
//  MusinsaAssignmentApp
//
//  Created by 김상혁 on 2022/07/14.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScene)
        let mainViewController = MainViewController()
        let mainViewModel = MainViewModel()
        mainViewController.viewModel = mainViewModel
        window?.rootViewController = mainViewController
        window?.makeKeyAndVisible()
    }
}

