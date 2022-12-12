//
//  AppDelegate.swift
//  Spacera
//
//  Created by Artem Bilyi on 09.12.2022.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    private let controller = CollectionViewTest()
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        window?.backgroundColor = .white
        let navigationController = UINavigationController(rootViewController: controller)
        window?.rootViewController = navigationController
        return true
    }
}

