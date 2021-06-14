//
//  SceneDelegate.swift
//  iOS_Study
//
//  Created by Jongho Lee on 2021/04/29.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

	var window: UIWindow?


	func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
		// Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
		// If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
		// This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).

//		window = UIWindow(windowScene: scene as! UIWindowScene)
//
//		if let activity = connectionOptions.userActivities.first {
//			configure(window: window, with: activity)
//		}	// 개발자가 원하는데로 화면 세팅?! 여기 까지 끝나면 화면이 등장한다.
//		Scene Delegate에서 Scene에 대한 stateRestorationActivity를 구현한 뒤 현재 창에서 가장 활동적인 사용자 활동을 찾는 메서드(fetchCurrentUserActivity)를 호출한다 그리고 이를 반환한다.

		guard let _ = (scene as? UIWindowScene) else { return }
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

		// Save changes in the application's managed object context when the application transitions to the background.
		(UIApplication.shared.delegate as? AppDelegate)?.saveContext()
	}

	/// called on scene background
	/// Encode state via NSUserActivity
	/// Data Protection
	/// scene based 상태 복원 API, 상태를 인코딩하여 창을 다시 만들 수 있다.
//	func stateRestorationActivity(for scene: UIScene) -> NSUserActivity? {
//		let currentActivity = fetchCurrentUserActivity(for: self.window)
//		return currentActivity
//	}
}

