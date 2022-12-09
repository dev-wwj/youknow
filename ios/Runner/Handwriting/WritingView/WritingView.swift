//
//  WritingCollectionView.swift
//  Runner
//
//  Created by wangwenjian on 2022/12/2.
//

import Foundation

let boxSize = 120

class WritingView: UIView {
    
    var images: [CellDate] = []
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        _ = collectionView
        _ = writerView
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        direction = [UIDeviceOrientation.landscapeLeft, UIDeviceOrientation.landscapeRight].contains(UIDevice.current.orientation) ? .horizontal : .vertical
    }
    
    var direction: ViewDirection = .vertical{
        didSet {
            if direction == .vertical {
                header.snp.remakeConstraints { make in
                    make.left.top.equalToSuperview()
                    make.height.equalTo(boxSize)
                    make.width.equalTo(boxSize + 8)
                }
                writerView.snp.remakeConstraints { make in
                    make.edges.equalTo(UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 8))
                }
                collectionView.snp.remakeConstraints { make in
                    make.top.equalToSuperview()
                    make.left.equalTo(header.snp.right)
                    make.height.equalTo(boxSize)
                    make.right.equalTo(0)
                }
            }else {
                header.snp.remakeConstraints { make in
                    make.left.top.equalToSuperview()
                    make.height.equalTo(boxSize + 8)
                    make.width.equalTo(boxSize)
                }
                writerView.snp.remakeConstraints { make in
                    make.edges.equalTo(UIEdgeInsets(top: 0, left: 0, bottom: 8, right: 0))
                }
                collectionView.snp.remakeConstraints { make in
                    make.top.equalTo(header.snp.bottom)
                    make.left.equalToSuperview()
                    make.width.equalTo(boxSize)
                    make.bottom.equalTo(0)
                }
            }
            collectionView.collectionViewLayout = flowLayout()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var writerView: HanziWriterView = {
        let view = HanziWriterView()
        header.addSubview(view)
        return view
    }()
    
    lazy var header: UIView = {
        let view = UIView()
        addSubview(view)
        return view
    }()
    
    lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout())
        collectionView.register(DrawedCell.self, forCellWithReuseIdentifier: "_cell")
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.contentInsetAdjustmentBehavior = .never
        collectionView.backgroundColor = UIColor.clear
        collectionView.delegate = self
        collectionView.dataSource = self
        addSubview(collectionView)
        return collectionView
    }()
    
    private func flowLayout() -> UICollectionViewFlowLayout {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: boxSize, height: boxSize)
        if direction == .vertical {
            layout.scrollDirection = .horizontal
            layout.minimumInteritemSpacing = 8
        }else {
            layout.scrollDirection = .vertical
            layout.minimumLineSpacing = 8
        }
        return layout
    }
    
}

extension WritingView: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        //        return images.count
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "_cell", for: indexPath) as! DrawedCell
//        cell.backgroundColor = .random()
        //        cell.imageView.image = images[indexPath.item].image
        //        cell.imageView.isHidden = !images[indexPath.item].show
        return cell
    }
    
}

