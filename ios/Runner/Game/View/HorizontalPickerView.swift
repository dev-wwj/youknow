//
//  HorizontalPickerView.swift
//  Runner
//
//  Created by wangwenjian on 2022/10/21.
//

import Foundation
import UIKit

class HerzintalCollectionViewLayout: UICollectionViewFlowLayout {
    
    // 用来缓存布局
    private var layoutAttributes: [UICollectionViewLayoutAttributes] = []
    override func prepare() {
        super.prepare()
        scrollDirection = .horizontal
    }
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        layoutAttributes = []
        let superLayoutAttributes = super.layoutAttributesForElements(in: rect)!
        
        let collectionViewCenterX = collectionView!.bounds.width * 0.5
        superLayoutAttributes.forEach { (attributes) in
            // 消除警告
            /**
             This is likely occurring because the flow layout subclass ColloectionLayout.LineLayout is modifying attributes returned by UICollectionViewFlowLayout without copying them
             */
            let copyLayout = attributes.copy() as! UICollectionViewLayoutAttributes
            // 和中心点的横向距离差
            let deltaX = abs(collectionViewCenterX - (copyLayout.center.x - collectionView!.contentOffset.x))
            // 计算屏幕内的cell的transform
            if deltaX < collectionView!.bounds.width {
                let _scale = 1.0 -  deltaX / collectionViewCenterX
                let scale = _scale > 0.5 ? _scale : 0.5
                copyLayout.transform = CGAffineTransform(scaleX: scale, y: scale)
                copyLayout.alpha = scale
            }
            layoutAttributes.append(copyLayout)
        }
        return layoutAttributes
    }
    /** 返回true将会标记collectionView的data为 'dirty'
     * collectionView检测到 'dirty'标记时会在下一个周期中更新布局
     * 滚动的时候实时更新布局
     */
    override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        return true
    }
}

class HorizontalPickerView: UICollectionView {
    
    convenience init(){
        let layout = HerzintalCollectionViewLayout()
        self.init(frame: .zero, collectionViewLayout: layout)
    }
    
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: .zero, collectionViewLayout: layout)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

fileprivate class CharCell: UICollectionViewCell {
    
    lazy var label: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 21, weight: .bold)
        label.textColor = .black
        contentView.addSubview(label)
        label.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        return label
    }()
}


class CharPickView: UICollectionView {
    
    var myChars: MyChars!
    
    var ScrollTo: ((Int) -> Void)? = nil
    
    convenience init(myChars: MyChars, scrollTo: @escaping (Int) -> Void){
        let layout = HerzintalCollectionViewLayout()
        self.init(frame: .zero, collectionViewLayout: layout)
        self.myChars = myChars
        self.ScrollTo = scrollTo
        self.backgroundColor = UIColor.clear
        self.register(CharCell.self, forCellWithReuseIdentifier: "_cell")
        self.showsHorizontalScrollIndicator = false
        self.delegate = self
        self.dataSource = self
        DispatchQueue.main.async {[unowned self] in
            let defaultIndex = IndexPath(item: myChars.index, section: 0)
            self.selectItem(at: defaultIndex, animated: false, scrollPosition: .centeredHorizontally)
            self.ScrollTo?(myChars.index)
        }
    }
 
    override func layoutSubviews() {
        super.layoutSubviews()
        if self.bounds.width > 0 {
            self.contentInset = UIEdgeInsets(top: 0, left: self.bounds.width/2, bottom: 0, right: self.bounds.width/2)
        }
    }
    
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: .zero, collectionViewLayout: layout)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension CharPickView: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let c = collectionView.dequeueReusableCell(withReuseIdentifier: "_cell", for: indexPath) as! CharCell
        c.label.text = myChars.chars[indexPath.item]
        return c
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return myChars.chars.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 50, height: 50)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("\(myChars.chars[indexPath.item])")
        alignAt(indexPath: indexPath)
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if !decelerate {
            self.endScroll()
        }
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        self.endScroll()
    }
}

extension CharPickView {
    fileprivate func endScroll( _ indexPath: IndexPath? = .none){
        let offsetX =  self.contentOffset.x
        var center = CGPoint(x: offsetX + self.bounds.size.width/2, y: 10)
        var indexPath: IndexPath?
        if let ip = self.indexPathForItem(at: center) {
            indexPath = ip
        } else {
            center.x += 20
            if let ip =  self.indexPathForItem(at: center) {
                indexPath = ip
            } else {
                center.x -= 40
                indexPath = self.indexPathForItem(at: center)
            }
        }
        guard let indexPath = indexPath else {
            return assertionFailure("Not find cell")
        }
        alignAt(indexPath: indexPath)
    }
    
    private func alignAt(indexPath: IndexPath) {
        self.selectItem(at: indexPath, animated: true, scrollPosition: .centeredHorizontally)
        ScrollTo?(indexPath.item)
    }
}
