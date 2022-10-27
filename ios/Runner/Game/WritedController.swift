//
//  WritedController.swift
//  Runner
//
//  Created by wangwenjian on 2022/10/24.
//

import Foundation

class WritedController: BaseViewController {
  
    override func viewDidLoad() {
        super.viewDidLoad()
        _ = collectionView
    }
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 60, height: 60)
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = 8
        layout.minimumLineSpacing = 8
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.contentInset = UIEdgeInsets(top: 10, left: 16, bottom: 0, right: 15)
        collectionView.register(DrawedCell.self, forCellWithReuseIdentifier: "__cell")
        collectionView.backgroundColor = UIColor.clear
        collectionView.delegate = self
        collectionView.dataSource = self
        safeView.addSubview(collectionView)
        collectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        return collectionView
    }()
}

extension WritedController: UICollectionViewDelegate, UICollectionViewDataSource {
  
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return DrawFileManager.manager.queryCount()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "__cell", for: indexPath) as! DrawedCell
        let paths =  DrawFileManager.manager.queryPath(indexPath.row);
        cell.paths = paths
        return cell
    }
}
