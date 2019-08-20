//
//  UIbarbuttomItem_extension.swift
//  DouYuZB
//
//  Created by 林雷 on 2019/8/19.
//  Copyright © 2019 林雷. All rights reserved.
//

import UIKit

extension UIBarButtonItem {
    //类方法
//    class func creatItem(imgName: String,HightImageName : String ,size :CGSize)-> UIBarButtonItem{
//        let btn = UIButton()
//        btn.setImage(UIImage(named: imgName), for: .normal)
//        btn.setImage(UIImage(named: HightImageName), for: .highlighted)
//        btn.frame = CGRect(origin: CGPoint(x: 0, y: 0), size: size)
//        return UIBarButtonItem(customView: btn)
//    }
    //构造方法 ->convenience关键字t开头 2.构造函数中必须调用一个设计构造函数的self 个：self.init()
    
    convenience init(imgName: String,HightImageName : String = "" ,size :CGSize = CGSize.zero ){
        //创建控件
        let btn = UIButton()
        //设置背景图片
        btn.setImage(UIImage(named: imgName), for: .normal)
        
        if HightImageName != ""{
             btn.setImage(UIImage(named: HightImageName), for: .highlighted)
        }
        //设置尺寸
        if size != CGSize.zero {
             btn.frame = CGRect(origin: CGPoint(x: 0, y: 0), size: size)
        }else{
          btn.sizeToFit()
        }
        //创建UIBarButtonItem
        self.init(customView :btn)
    }
}
