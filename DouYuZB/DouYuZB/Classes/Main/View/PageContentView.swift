//
//  PageContentView.swift
//  DouYuZB
//
//  Created by 林雷 on 2019/8/20.
//  Copyright © 2019 林雷. All rights reserved.
//

import UIKit
protocol PageContentViewDelegate : class {
    func pageContentView(contentView : PageContentView ,progess:CGFloat ,soruceIndex :Int, tageateIndex:Int)
    
}

private let contentViewCellId = "cell"
class PageContentView: UIView {
    weak var delegate :PageContentViewDelegate?
    private var startofsetX : CGFloat = 0
    private var childVcs: [UIViewController]
    private  weak var parentViewController : UIViewController?
    private lazy var collectionView : UICollectionView = { [weak self] in
       let layout = UICollectionViewFlowLayout()
        layout.itemSize = (self?.bounds.size)!
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.scrollDirection = .horizontal
        
        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.isPagingEnabled = true
        collectionView.bounces = true
        collectionView.dataSource = self
        collectionView.scrollsToTop = false
        collectionView.delegate = self
       
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: contentViewCellId)
        return collectionView
    }()
    init(frame: CGRect ,childVcs :[UIViewController] ,parentViewController: UIViewController?) {
        self.childVcs = childVcs
        self.parentViewController = parentViewController
        super.init(frame: frame)
        
        setupUI()
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
   
}

extension PageContentView {
    private func setupUI() {
        for childvc in childVcs {
            parentViewController?.addChild(childvc)
        }
        addSubview(collectionView)
        collectionView.frame = bounds
        
        
    }
}

extension PageContentView :UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return childVcs.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: contentViewCellId, for: indexPath)
        for view in cell.contentView.subviews {
            view.removeFromSuperview()
        }
        let childVc = childVcs[indexPath.item]
        childVc.view.frame = cell.contentView.bounds
        cell.contentView.addSubview(childVc.view)
        return cell
    }
}
extension PageContentView :UICollectionViewDelegate {
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
      startofsetX =  scrollView.contentOffset.x
    }
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        var progress : CGFloat = 0
        var soruceIndex = 0
        var tagetIndex = 0

        let scrollViewW: CGFloat = scrollView.frame.size.width
        let currentOffsetX = scrollView.contentOffset.x
        
        if currentOffsetX > startofsetX {//左滑 floor 取整
            progress = currentOffsetX / scrollViewW - floor(currentOffsetX / scrollViewW)
            soruceIndex = Int(currentOffsetX / scrollViewW)
            tagetIndex = soruceIndex + 1
            if tagetIndex >= childVcs.count{
                 tagetIndex = soruceIndex - 1
            }
            if currentOffsetX - startofsetX == scrollViewW {
                progress = 1
            }
        }else{
            progress =  1 - (currentOffsetX / scrollViewW - floor(currentOffsetX / scrollViewW))
            tagetIndex = Int(currentOffsetX / scrollViewW)
            soruceIndex = tagetIndex + 1
            if soruceIndex >= childVcs.count{
                tagetIndex = soruceIndex - 1
            }
            if startofsetX - currentOffsetX == scrollViewW {
                progress = 1
            }
        }
        delegate?.pageContentView(contentView: self, progess: progress, soruceIndex: soruceIndex, tageateIndex: tagetIndex)
        
    }
}
//对外暴露方法
extension PageContentView {
    func setCurrentIndex(currtentIndex :Int)  {
        let offsetX = CGFloat(currtentIndex) * collectionView.frame.width
        collectionView.setContentOffset(CGPoint(x: offsetX, y: 0), animated: true)
    }
}



