//
//  UIView+Extension.swift
//  Runner
//
//  Created by wangwenjian on 2022/10/14.
//

import Foundation
import UIKit

extension UIView {
    func snapshot() -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(self.bounds.size, self.isOpaque, 0)
        if let context = UIGraphicsGetCurrentContext() {
            self.layer.render(in: context)
        }
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }
}
