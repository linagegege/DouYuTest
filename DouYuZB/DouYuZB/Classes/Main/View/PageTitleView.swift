//
//  PageTitleView.swift
//  DouYuZB
//
//  Created by 林雷 on 2019/8/20.
//  Copyright © 2019 林雷. All rights reserved.
//

import UIKit
//1.声明代理
protocol PageTitleViewDelegate : class {
    func pageTitleView(titleView : PageTitleView,selectedIndex  index:Int)
}
private let klineH :CGFloat = 2
private let klineViewH :CGFloat = 0.5


class PageTitleView: UIView {
    //自定义构造函数 必须重写required init?(coder aDecoder: NSCoder)
    private var currentIndex: Int = 0
    //2.设置代理属性
    weak var delegate : PageTitleViewDelegate?
    fileprivate var titles: [String]
    fileprivate lazy var lables: [UILabel] = [UILabel]()
    fileprivate lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.bounces = true
        scrollView.scrollsToTop = false
        return scrollView
    }()
    fileprivate lazy var lineView: UIView = {
        let lineView =  UIView()
        lineView.backgroundColor = UIColor.lightGray
        return lineView
    }()
    fileprivate lazy var scrollLine : UIView = {
        let scrollLine = UIView()
        scrollLine.backgroundColor = UIColor.orange
        return scrollLine
    }()
    
     init(frame: CGRect ,titles:[String]) {
        self.titles = titles
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
extension PageTitleView {
    private func setupUI() {
        scrollView.frame = bounds
        addSubview(scrollView)
        setupTitleLabels()
        setupBottomLineView()
    }
   

    private func setupTitleLabels() {
        let lalbeH : CGFloat = frame.height - CGFloat(klineH)
        let lableW : CGFloat = kScreenW / CGFloat(titles.count)
        let lableY : CGFloat = 0
        
        for (index, item) in titles.enumerated() {
            let lable = UILabel()
            
            lable.text = item
            lable.font = UIFont.systemFont(ofSize: 16)
            lable.tag = index
            lable.textAlignment = .center
            lable.textColor = UIColor(red: 85/255.0, green: 85/255.0, blue: 85/255.0, alpha: 1.0)
            
            lable.frame = CGRect(x: lableW * CGFloat(index), y: lableY, width: lableW, height: lalbeH)
            scrollView.addSubview(lable)
            lables.append(lable)
            lable.isUserInteractionEnabled = true
            let gusest = UITapGestureRecognizer(target: self, action: #selector(self.titleLableClick(tapGus:)))
            lable.addGestureRecognizer(gusest)
        }
    }
    
    private func setupBottomLineView() {
        lineView.frame = CGRect(x: 0, y: frame.height - klineViewH, width: kScreenW, height: klineViewH)
        addSubview(lineView)
        scrollView.addSubview(scrollLine)
        guard let fristLable = lables.first else {return}
        fristLable.textColor = UIColor.orange
        scrollLine.frame = CGRect(x: fristLable.frame.origin.x, y: scrollView.frame.height - klineH, width: fristLable.frame.width, height: klineH)
        
    }
}
extension PageTitleView{
    @objc private func titleLableClick(tapGus: UITapGestureRecognizer){
        guard let currenLable = tapGus.view as?UILabel else {
            return
        }
        let oldleble = lables[currentIndex]
        currentIndex = currenLable.tag
        
        currenLable.textColor = UIColor.orange
        oldleble.textColor = UIColor.darkGray
        
        currentIndex = currenLable.tag
        
        let scrollLinePosition = CGFloat(currenLable.tag) * scrollLine.frame.width
        UIView.animate(withDuration: 0.2) {
            self.scrollLine.frame.origin.x = scrollLinePosition
        }
        //3.代理发送通知
        delegate?.pageTitleView(titleView: self, selectedIndex: currentIndex)
    }
}

//对外暴露方法
extension PageTitleView {
    func setTitleViewProgress(progress : CGFloat ,soruceIndex:Int ,tagetIndex: Int)  {
        
    }
}
