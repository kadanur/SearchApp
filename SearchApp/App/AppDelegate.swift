//
//  AppDelegate.swift
//  SearchApp
//
//  Created by M Kaan Adanur on 29.04.2022.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    static let wantedHeightMultiplier = (Int(UIScreen.main.bounds.height) / 2)
    static let modForWantedTableViewHeight = (AppDelegate.wantedHeightMultiplier) % AppDelegate.cellHeight
    static var wantedTableViewHeight = AppDelegate.wantedHeightMultiplier - AppDelegate.modForWantedTableViewHeight
//    static var wantedTableViewHeight = SecondViewController.menuArray.count * AppDelegate.cellHeight
    static var cellHeight = 52
    static var listedCells = AppDelegate.wantedTableViewHeight / AppDelegate.cellHeight

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

