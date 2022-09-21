//
//  BaseViewController.swift
//  Runner
//
//  Created by wangwenjian on 2022/9/15.
//

import Foundation
import UIKit

class BaseViewController: UIViewController {
    let safeView = UIView()
    override func viewDidLoad(){
        view.addSubview(safeView)
    }
    
    override func viewSafeAreaInsetsDidChange() {
        self.view.layoutIfNeeded()
        safeView.snp.updateConstraints { make in
            make.edges.equalTo(view.safeAreaInsets)
        }
    }

   
}
