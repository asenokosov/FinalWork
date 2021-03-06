//
//  AppDelegate.swift
//  FinalWork
//
//  Created by Uzver on 15.12.2020.
//

import UIKit
import RealmSwift
import Firebase

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
	
	func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
		FirebaseApp.configure()
		let config = Realm.Configuration(
			schemaVersion: 3,
			migrationBlock: { migration, oldSchemaVersion in
				if (oldSchemaVersion < 1) {
				}
			})
		Realm.Configuration.defaultConfiguration = config
		return true
	}
	
	// MARK: UISceneSession Lifecycle
	
	func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
		return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
	}
	
	func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
	}
	
	
}

