//
//  DrawedCell.swift
//  Runner
//
//  Created by wangwenjian on 2022/10/14.
//

import Foundation
import UIKit


struct CellData {
    let image: UIImage
    var show: Bool
    
    mutating func setShow(){
        show = true
    }
}

class DrawedCell: UICollectionViewCell {
    
    lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.borderColor = 0xD0D0D0.color?.cgColor
        imageView.layer.borderWidth = 1.0
        addSubview(imageView)
        imageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        return imageView
    }()
    
    var paths: [DPath]? {
        didSet {
            guard let paths = paths else {
                return
            }
            let view = DrawedView(paths: paths)
            imageView.image = view.snapshot()
        }
    }
    
}

