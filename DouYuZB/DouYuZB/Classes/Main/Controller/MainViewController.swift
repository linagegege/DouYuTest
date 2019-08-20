//
//  MainViewController.swift
//  DouYuZB
//
//  Created by 林雷 on 2019/8/19.
//  Copyright © 2019 林雷. All rights reserved.
//

import UIKit

class MainViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        addChildVC("Home")
        addChildVC("Live")
        addChildVC("Follow")
        addChildVC("Profile")
       
        
        }
    private func addChildVC(_ storyName : String){
        let childVC = UIStoryboard(name: storyName, bundle: nil).instantiateInitialViewController()!
        
        addChild(childVC)
    }
    

   
}
