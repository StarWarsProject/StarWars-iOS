//
//  SceneDelegate.swift
//  StarWars-iOS
//
//  Created by admin on 11/22/22.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    var appCoordinator: AppCoordinator?
    static weak var shared: SceneDelegate?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        Self.shared = self
        setupRootControllerIfNeeded()
        // swiftlint:disable force_cast
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.window = self.window
        // swiftlint:disable unused_optional_binding
        guard let _ = (scene as? UIWindowScene) else { return }
    }

    func setupRootControllerIfNeeded() {
        let navigationCon = UINavigationController.init()
        navigationCon.isNavigationBarHidden = true
        appCoordinator = AppCoordinator(navigationController: navigationCon)
        appCoordinator!.start()
        self.window?.rootViewController = navigationCon
        self.window?.makeKeyAndVisible()
    }

    func sceneDidDisconnect(_ scene: UIScene) {

    }

    func sceneDidBecomeActive(_ scene: UIScene) {
    }

    func sceneWillResignActive(_ scene: UIScene) {
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        CoreDataManager.shared.saveContext()
    }

//    private func getRootViewController() -> UIViewController {
//        let navController = UINavigationController(rootViewController: HomeViewController())
//        navController.isNavigationBarHidden = true
//        return navController
//    }

}
