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

import MBProgressHUD
extension Tool {
    // MARK: HUD
    static func hudHelper(_ hint: String)->MBProgressHUD{
        let view: UIView? = UIApplication.shared.keyWindow
        let hud = MBProgressHUD.showAdded(to: view!, animated: true)
        hud.isUserInteractionEnabled = false
        hud.mode = MBProgressHUDMode.text
        hud.label.text = hint
        hud.label.numberOfLines = 0
        hud.label.font = UIFont.systemFont(ofSize: CGFloat(15))
        hud.margin = 10.0
        hud.offset = CGPoint(x: CGFloat(hud.offset.x), y: CGFloat(0))
        hud.removeFromSuperViewOnHide = true
        return hud
    }
    
    static func showMiddleHint(_ hint: String,shouldHide:Bool)->MBProgressHUD {
        let hud = hudHelper(hint)
        if shouldHide {
            hud.hide(animated: true, afterDelay: 3)
        }
        return hud
    }
    
    static func showMiddleHint(_ hint: String,shouldHide:Bool, delay:TimeInterval)->MBProgressHUD {
        let hud = hudHelper(hint)
        if shouldHide {
            hud.hide(animated: true, afterDelay: delay)
        }
        return hud
    }
    
    static func showErrorHint(_ hint: String){
        let hud = hudHelper(hint)
        hud.contentColor = UIColor.red
        hud.hide(animated: true, afterDelay: 3)
    }
}
