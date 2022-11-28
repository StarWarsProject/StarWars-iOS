//
//  SceneDelegate.swift
//  StarWars-iOS
//
//  Created by admin on 11/22/22.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
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
        let rootViewController = createNavController(for: HomeViewController(), title: "Star Wars App", image:
                                                        UIImage(systemName: "newspaper.fill") ?? UIImage())
        self.window?.rootViewController = rootViewController
        self.window?.makeKeyAndVisible()
    }

    fileprivate func createNavController(for rootViewController: UIViewController, title: String, image: UIImage) -> UIViewController {
        let navController = UINavigationController(rootViewController: rootViewController)
        navController.tabBarItem.title = title
        navController.tabBarItem.image = image

        // navController.navigationBar.prefersLargeTitles = true
        // navController.navigationBar.backgroundColor = UIColor(named: "primary")
        navController.navigationBar.tintColor = .black

        let appearance = UINavigationBarAppearance()
        appearance.backgroundColor = UIColor(named: "primary")
        appearance.titleTextAttributes = [.foregroundColor: UIColor.black]
        appearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]

        navController.navigationBar.standardAppearance = appearance
        navController.navigationBar.scrollEdgeAppearance = appearance
        navController.modalPresentationStyle = .overFullScreen

        rootViewController.navigationItem.title = title

        return navController
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

    private func getRootViewController() -> UIViewController {
        let navController = UINavigationController(rootViewController: HomeViewController())
        navController.isNavigationBarHidden = true
        return navController
    }

}
