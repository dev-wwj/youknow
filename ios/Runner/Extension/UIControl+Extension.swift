//
//  UIController+Extension.swift
//  步多多
//
//  Created by wangwenjian on 2022/7/20.
//  Copyright © 2022 songheng. All rights reserved.
//

import Foundation
import UIKit

var ActionBlockKey = "UIControl.actionBlockKey"

extension UIControl {
    
    func tapAction( _ event:Event, action: @escaping (UIControl) -> Void) {
        if self.xyz_btnActionBlock != nil {
            return
        }
        self.xyz_btnActionBlock = action
        self.addTarget(self, action: #selector(btnActionFunc), for: event)
    }
    
    @objc private func btnActionFunc(){
        self.xyz_btnActionBlock?(self)
    }
    
    private var xyz_btnActionBlock: ((_ btn: UIControl) -> Void)? {
        set {
            objc_setAssociatedObject(self, &ActionBlockKey, newValue, .OBJC_ASSOCIATION_COPY_NONATOMIC)
        }
        get {
            return objc_getAssociatedObject(self, &ActionBlockKey) as? ((UIControl) -> Void)
        }
    }
}
