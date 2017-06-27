//
//  WWLocatingPlistVC.swift
//  SJPushFlowDemo
//
//  Created by work_mac on 2017/6/15.
//  Copyright © 2017年 IAsk. All rights reserved.
//

import UIKit

enum PlistViewControllerError: Error {
    case namePlaceError
    case noCanChangeError
}

enum PlistFindError: Error{
    case noFandPathError

}


class SJLocatingPlistVC {

    var plistVC = UIViewController.init()
    
    
    
    /// 读取数据
    func loadData() throws -> NSDictionary {
        
        //获取数据文件地址
        guard let path = Bundle.main.path(forResource: "PropertyList", ofType: "plist") else {
           throw PlistFindError.noFandPathError
        }
        
        let dataDic = NSDictionary.init(contentsOfFile: path)
        
        return dataDic!
    }
    
    
    
    func addChildViewController(childControllerName: String) throws -> UIViewController.Type{
        
        guard let clsName = Bundle.main.infoDictionary!["CFBundleExecutable"] else {
            throw PlistViewControllerError.namePlaceError
        }
        
        // 2.通过命名空间和类名转换成类
        let cls : AnyClass? = NSClassFromString((clsName as! String) + "." + childControllerName)
        
        // swift 中通过Class创建一个对象,必须告诉系统Class的类型
        guard let clsType = cls as? UIViewController.Type else {
            throw PlistViewControllerError.noCanChangeError
        }
        return clsType;
    }
    
}



    
