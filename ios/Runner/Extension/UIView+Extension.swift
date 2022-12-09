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
        UIGraphicsBeginImageContextWithOptions(self.bounds.size, false, 0.8)
        if let context = UIGraphicsGetCurrentContext() {
            self.layer.render(in: context)
        }
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }
    
    func toPngData() -> Data? {
        guard let image = self.snapshot() else {
            assertionFailure("view to image fail")
            return nil
        }
        return image.jpegData(compressionQuality: 0.5)
    }
    
    func viewController() -> UIViewController? {
        var next = superview
        while next != nil {
            let nextResponder = next?.next
            if nextResponder is UINavigationController ||
                nextResponder is UIViewController
            {
                return nextResponder as? UIViewController
            }
            next = next?.superview
        }
        return nil
    }
}
