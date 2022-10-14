//
//  GameViewController+CollectionView.swift
//  Runner
//
//  Created by wangwenjian on 2022/10/14.
//

import Foundation
import UIKit

extension GameViewController: UICollectionViewDelegate, UICollectionViewDataSource {
   
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "_cell", for: indexPath) as! DrawedCell
        cell.imageView.image = images[indexPath.item].image
        cell.imageView.isHidden = !images[indexPath.item].show
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
    }
    
    
    
    
}
