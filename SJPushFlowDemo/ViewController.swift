//
//  ViewController.swift
//  SJPushFlowDemo
//
//  Created by work_mac on 2017/6/27.
//  Copyright © 2017年 IAsk. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.white
        
        
        let button = UIButton.init(type: UIButtonType.custom)
        button.frame = CGRect.init(x: 100, y: 250, width: 100, height: 50)
        button.setTitle("点击", for: UIControlState.normal)
        button.addTarget(self, action:#selector(ViewController.buttonClick), for: UIControlEvents.touchUpInside)
        button.backgroundColor = UIColor.gray
        self.view.addSubview(button)
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    func buttonClick() {
        let dictionary:Dictionary<String,String> = ["messageType":"1","businessId":"1245243563656","alert":"你好"];
        
        SJPushDataOperation.registerApp(pushData: dictionary as NSDictionary, isPushWeakApp: false)
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

