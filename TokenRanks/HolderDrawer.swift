//
//  Drawer.swift
//  TokenRanks
//
//  Created by Gelei Chen on 20/9/2017.
//  Copyright © 2017 Gelei. All rights reserved.
//

import Foundation
import MMDrawerController
extension TokenHolderViewController{
    func leftBarClicked(){
        if let drawerVC = getDrawerController() {
            drawerVC.toggle(.left, animated: true, completion: nil)
        }
    }
    
    func getDrawerController() -> MMDrawerController? {
        var parentViewController: UIViewController? = parent
        while parentViewController != nil {
            if (parentViewController is MMDrawerController) {
                return (parentViewController as? MMDrawerController)!
            }
            parentViewController = parentViewController?.parent
        }
        return nil
    }
}

