//
//  SceneDelegate.swift
//  SMU Signal
//
//  Created by 이승준 on 4/11/25.
//

import UIKit
import Alamofire

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(frame: windowScene.coordinateSpace.bounds)
        window?.windowScene = windowScene
        window?.makeKeyAndVisible()
        window?.overrideUserInterfaceStyle = .light
//        print(KeychainService.get(key: K.APIKey.accessToken) ?? "")
        APIService.checkToken { result in
            switch result {
            case .success: // home
                RootViewControllerService.toHomeViewController()
            case .expired: // login
                RootViewControllerService.toLoginController()
            case .idealNotCompleted: // ideal
                RootViewControllerService.toIdealViewController()
            case .signupNotCompleted: // signup
                RootViewControllerService.toSignUpViewController()
            case .error: // ??
                self.window?.rootViewController = NetworkErrorViewController()
                break
            }
        }
    }
    
    func changeRootViewController(_ viewController: UIViewController, animated: Bool) {
        guard let window = self.window else { return }
        
        if animated {
            let snapshot = window.snapshotView(afterScreenUpdates: true)
            viewController.view.addSubview(snapshot!)
            
            window.rootViewController = viewController
            
            UIView.animate(withDuration: 0.3, animations: {
                snapshot?.alpha = 0
            }, completion: { _ in
                snapshot?.removeFromSuperview()
            })
        } else {
            window.rootViewController = viewController
        }
        
        // 이전 루트 뷰 컨트롤러의 메모리 해제 유도
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            autoreleasepool {}
        }
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

