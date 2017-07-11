//
//  WWPushDataOperation.swift
//  SJPushFlowDemo
//
//  Created by work_mac on 2017/6/15.
//  Copyright © 2017年 IAsk. All rights reserved.
//

/*
 修改本类 messagetype与vc 与你使用的plist文件key值对应即可
 */



import UIKit


public class SJPushDataOperation{
    
    internal static var dataOperation: PushDataOperation?
    
    /// - Parameters:
    ///   - plistName: plist文件名
    ///   - pushData: 推送数据
    ///   - isPushWeakApp: 在appDelegate里面判断是否是从外部push进入 isPushWeakApp是根据 判断 launchOptions?[UIApplicationLaunchOptionsKey.remoteNotification] 是否有值所赋值的
    public class func registerApp(plistName:String, pushData: NSDictionary, isPushWeakApp: Bool){
        
        dataOperation = PushDataOperation(plistName: plistName, pushData: pushData, isPushWeakApp: isPushWeakApp)
        
    }
    
}


class PushDataOperation {
    
    let rootVC: UIViewController!
    var plistVC: UIViewController!
    
    init(plistName: String,pushData: NSDictionary, isPushWeakApp: Bool)
    {
        
        // 查找当前主vc
        let window = UIApplication.shared.windows.first
        let locatingRoot = SJLocatingRootVC()
        rootVC = locatingRoot.getCurrentController(rootVC: (window?.rootViewController!)!)
        
        self.locatingPlistVC(plistName: plistName,pushData: pushData)
        
        //  在locatingPlistVC已经赋值plistVC， 若plistVC为空 就没必要进行下面步骤
        if plistVC == nil {
            return
        }
        
        if self.applicationStateIsActive(isPushWeakApp: isPushWeakApp) == true
        {
            self.showAlertWithMessage(message: pushData.object(forKey: "alert") as! String, cancel: { (UIAlertAction) in
                print("取消")
            }, goSee: { (UIAlertAction) in
                self.vcSkip(pushData: pushData)
            })
        }
        else
        {
            self.vcSkip(pushData: pushData)
        }
        
    }
    
    /// 查找plist文件里面的vc  并且实例化
    ///
    /// - Parameter pushData: 推送过来的数据   此步骤只需messageType字段 来查找对应vc
    func locatingPlistVC(plistName: String,pushData: NSDictionary){
        
        let locatingPlist = SJLocatingPlistVC()
        
        do{
             let dic = try locatingPlist.loadData(plistName: plistName)
            
             let key = pushData.object(forKey: "messageType") as! String
            
             //  messageType  消息类型 可自定义
            guard let plistDic = dic.object(forKey: key) else {
                print("未找到对应的type")
                return
            }
            
            
            do{
                let findVC = try locatingPlist.addChildViewController(childControllerName: (plistDic as! NSDictionary).object(forKey: "vc") as! String)
                self.plistVC = findVC.init()
            } catch PlistViewControllerError.namePlaceError {
                print("命名空间不存在")
            } catch PlistViewControllerError.noCanChangeError {
                print("无法转换成UIViewController")
            } catch {
                print("未知error")
            }
            
        } catch {
             print("未找到文件夹")
        }
        
    }
    

    /// 页面跳转
    func vcSkip(pushData: NSDictionary){
        
        // 判断vc是否满足 更新数据协议
        self.protocolViewController(pushData: pushData)
        
        if rootVC.navigationController != nil
        {
            rootVC.navigationController?.pushViewController(plistVC, animated: true)
        }
        else
        {
            rootVC.present(plistVC, animated: true, completion: nil)
        }
    }
    
    
    /// 判断app是否在运行中
    /// - Parameter isPushWeakApp: 是否是系统推送进来的
    /// - Returns:
    func applicationStateIsActive(isPushWeakApp: Bool) -> Bool {
        
        if UIApplication.shared.applicationState == UIApplicationState.active
        {
            if (isPushWeakApp == true) {
                return false;
            }
           return true
        }
        else
        {
           return false
        }
    }
    
    
    func protocolViewController(pushData: NSDictionary){
        if plistVC is SJPushDataVCProtocol {
            (plistVC as! SJPushDataVCProtocol).upData(pushData: pushData)
        }
    }
    
    
    
    /// app运行中 有推送进来显示alert
    ///
    /// - Parameters:
    ///   - message: 消息
    ///   - cancel: 取消事件
    ///   - goSee:  下一步事件
    func showAlertWithMessage(message: String, cancel: @escaping (UIAlertAction) -> Void , goSee: @escaping (UIAlertAction) -> Void ){
        
        let alertController = UIAlertController.init(title: "提示", message: message, preferredStyle: UIAlertControllerStyle.alert)
       
        let cancelAction = UIAlertAction.init(title: "取消", style: UIAlertActionStyle.cancel, handler: cancel)
        let goSeeAction = UIAlertAction.init(title: "去看看", style: UIAlertActionStyle.default, handler: goSee)
        
        alertController.addAction(cancelAction)
        alertController.addAction(goSeeAction)
        rootVC.present(alertController, animated: true, completion: nil)
    }
    
    
}



















