//
//  SceneDelegate.swift
//  MFG-ChatAppMVVM
//
//  Created by Mustafa Fatih on 4/9/24.
//

import UIKit
import FirebaseAuth

class SceneDelegate: UIResponder, UIWindowSceneDelegate, LoginProtocol, LogoutProtocol, SplashDelegate {
    
    
    
    

    var window: UIWindow?
    let mainTabBarController = MainTabBarController()
    let loginVC = LoginViewController()
    let splashVC = SplashVC()

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(frame: windowScene.coordinateSpace.bounds)
        window?.windowScene = windowScene
        
        //Arranging delegates
        loginVC.loginDelegate = self
        mainTabBarController.moreVC.delegateLogout = self
        splashVC.delegate = self
        self.window?.rootViewController = splashVC
        self.window?.makeKeyAndVisible()

    }
    
    func splashDidFinish() {
        
        if Auth.auth().currentUser?.uid == nil {
            let navigationLoginVC = UINavigationController(rootViewController: loginVC)
            self.window?.rootViewController = navigationLoginVC
        }
        else{
            self.window?.rootViewController = mainTabBarController
        }
   
    }
    
    
    func loggedIn() {
        print("Log in")
        
        
    }
    
    func logoutPerformed() {
        let navigationLoginVC = UINavigationController(rootViewController: loginVC)
        self.window?.rootViewController = navigationLoginVC
    }
    
    
    
    
    
    

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }


}

