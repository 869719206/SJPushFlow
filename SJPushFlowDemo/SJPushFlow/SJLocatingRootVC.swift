//
//  WWLocatingRootVC.swift
//  SJPushFlowDemo
//
//  Created by work_mac on 2017/6/15.
//  Copyright © 2017年 IAsk. All rights reserved.
//

import UIKit


class SJLocatingRootVC {

    dynamic func getCurrentController(rootVC: UIViewController) -> UIViewController! {
        
        if (rootVC.isKind(of: UITabBarController.classForCoder()))
        {
            return self.getCurrentController(rootVC: ((rootVC as! UITabBarController).selectedViewController)!)
        }
        else if (rootVC.isKind(of: UINavigationController.classForCoder()))
        {
            return self.getCurrentController(rootVC: ((rootVC as! UINavigationController).visibleViewController)!)
        }
        else if ((rootVC.presentedViewController) != nil)
        {
            return rootVC.presentedViewController
        }
        else
        {
            return rootVC
        }
    }
    
}
