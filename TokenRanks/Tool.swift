//
//  File.swift
//  TokenRanks
//
//  Created by Gelei Chen on 20/9/2017.
//  Copyright © 2017 Gelei. All rights reserved.
//

import Foundation
import MMDrawerController

struct Tool {
    private static let appDelegate = UIApplication.shared.delegate as! AppDelegate
    private static let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
    
    private static func setFirstVC(initailVC:UIViewController){
        appDelegate.window = UIWindow(frame: UIScreen.main.bounds)
        appDelegate.window!.rootViewController = initailVC
        appDelegate.window!.makeKeyAndVisible()
    }
    static func setArchiveEntryPoint(){
        let mainStoryboard = UIStoryboard.init(name: "Main", bundle: nil)
        let centerVC = mainStoryboard.instantiateViewController(withIdentifier: "ArchiveNavigationController")
        let leftSideDrawerViewController = mainStoryboard.instantiateViewController(withIdentifier: "SettingViewController")
        let leftNavigationVC = UINavigationController(rootViewController: leftSideDrawerViewController)
        let drawerController = MMDrawerController(center: centerVC, leftDrawerViewController: leftNavigationVC)!
        drawerController.showsShadow = true
        drawerController.maximumLeftDrawerWidth = Constant.SCREEN_WIDTH * 5 / 6
        drawerController.closeDrawerGestureModeMask = .all
        setFirstVC(initailVC: drawerController)
    }
}
