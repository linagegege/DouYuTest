//
//  HomeViewController.swift
//  DouYuZB
//
//  Created by 林雷 on 2019/8/19.
//  Copyright © 2019 林雷. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    private lazy var pageTitleView:PageTitleView = { [weak self] in
        let frame = CGRect(x: 0, y: kstateH+knavBarH, width:kScreenW, height: ktitleH)
        let titles = ["推荐","游戏","娱乐","趣玩"];
        let titleVeiw = PageTitleView(frame: frame, titles: titles)
        //4.外部声明要用代理
        titleVeiw.delegate = self
        return titleVeiw
    }()
    
    private lazy var pageContentView: PageContentView = {[weak self] in
        let contentH = kScreenH - kstateH - knavBarH - ktitleH
        let contentFrame = CGRect(x: 0, y: kstateH + knavBarH + ktitleH, width:kScreenW, height: contentH)
        var childVcs: [UIViewController] = [UIViewController]()
        for _ in 0..<4{
            let childVc :UIViewController = UIViewController()
            childVc.view.backgroundColor = UIColor(r:CGFloat(arc4random_uniform(256)), g: CGFloat(arc4random_uniform(256)), b: CGFloat(arc4random_uniform(256)))
            childVcs.append(childVc)
        }
        
        let pageContentView = PageContentView(frame: contentFrame, childVcs: childVcs, parentViewController: self)
        
        pageContentView.delegate = self
        return pageContentView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        //设置UI界面
       
        setupUI()
    }
    
    
}

extension HomeViewController {
    private func setupUI() {
        automaticallyAdjustsScrollViewInsets = false
        setupNavbar()
        view.addSubview(pageTitleView)
        view.addSubview(pageContentView)
    
    }
    private func setupNavbar() {
        let size = CGSize(width: 40, height: 40)
        let  btn = UIBarButtonItem(imgName: "logo")
        navigationItem.leftBarButtonItem = btn
        
        let  historyItem = UIBarButtonItem(imgName: "image_my_history", HightImageName: "Image_my_history_click", size: size)
        let searchyItem = UIBarButtonItem(imgName: "btn_search", HightImageName: "btn_search_clicked", size: size)
        let qrcodetem = UIBarButtonItem(imgName: "Image_scan", HightImageName: "Image_scan_click", size: size)
        
        navigationItem.rightBarButtonItems = [historyItem,searchyItem,qrcodetem]
    }
}
//5.外部接受代理实现代理
extension HomeViewController : PageTitleViewDelegate {
    
    func pageTitleView(titleView: PageTitleView, selectedIndex index: Int) {
        pageContentView.setCurrentIndex(currtentIndex: index)
    }
    
}

extension HomeViewController : PageContentViewDelegate {
    func pageContentView(contentView: PageContentView, progess: CGFloat, soruceIndex: Int, tageateIndex: Int) {
       pageTitleView.setTitleViewProgress(progress: progess, soruceIndex: soruceIndex, tagetIndex: tageateIndex)
    }
}
