//
//  ViewControllerTwo.swift
//  SJPushFlowDemo
//
//  Created by work_mac on 2017/6/14.
//  Copyright © 2017年 IAsk. All rights reserved.
//

import UIKit


class ViewControllerTwo : UIViewController,SJPushDataVCProtocol {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.white
        
        
        let button = UIButton.init(type: UIButtonType.custom)
        button.frame = CGRect.init(x: 100, y: 150, width: 100, height: 50)
        button.setTitle("返回", for: UIControlState.normal)
        button.addTarget(self, action:#selector(ViewControllerTwo.buttonClick), for: UIControlEvents.touchUpInside)
        button.backgroundColor = UIColor.red
        self.view.addSubview(button)
        
        
        
        self.view.backgroundColor = UIColor.white
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    func buttonClick() {
        
        if self.navigationController != nil
        {
            self.navigationController?.popViewController(animated: true)
        }
        else
        {
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    func upData(pushData: NSDictionary){
        
        
         print(pushData)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

    
