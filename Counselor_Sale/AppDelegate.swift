//
//  AppDelegate.swift
//  Counselor_Sale
//
//  Created by Teddy Kwak on 2017. 2. 28..
//  Copyright © 2017년 Teddy Kwak. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        UINavigationBar.appearance().barTintColor = ColorPalette.itiMedium
        UINavigationBar.appearance().tintColor = ColorPalette.itiWhite
        UINavigationBar.appearance().titleTextAttributes = [NSFontAttributeName: UIFont.AppleSDGothicNeosemiBold(ofSize: 20), NSForegroundColorAttributeName: ColorPalette.itiWhite]
        
        UITabBar.appearance().tintColor = ColorPalette.itiMedium

        let tabbarFont = UIFont.AppleSDGothicNeosemiBold(ofSize: 10)
        let selectedColor   = ColorPalette.itiMedium
        let unselectedColor = ColorPalette.itiGray
        
        UITabBarItem.appearance().setTitleTextAttributes([NSFontAttributeName: tabbarFont, NSForegroundColorAttributeName: unselectedColor], for: .normal)
        UITabBarItem.appearance().setTitleTextAttributes([NSFontAttributeName: tabbarFont, NSForegroundColorAttributeName: selectedColor], for: .selected)
        
        
        let userDefault = UserDefaults.standard
        
        if userDefault.object(forKey: "msg") != nil {
            let story = UIStoryboard(name: "Main", bundle: nil)
            let tab = story.instantiateViewController(withIdentifier: "mainTabbar")
            window?.rootViewController = tab
        }
        
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}


extension UIColor {
    static func rgb(_ red: CGFloat, green: CGFloat, blue: CGFloat) -> UIColor {
        return UIColor(red: red/255, green: green/255, blue: blue/255, alpha: 1)
    }
}

