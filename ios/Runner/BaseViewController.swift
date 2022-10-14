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
    
    let navigationBar = UIView()
    
    override func viewDidLoad(){
        navigationBar.backgroundColor = UIColor.red
        view.addSubview(safeView)
        view.addSubview(navigationBar)
    }
    
    override var title: String? {
        didSet {
            guard let title = title else {
                return
            }
            titleLabel.text = title
        }
    }
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.white
        label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        navigationBar.addSubview(label)
        label.snp.makeConstraints { make in
            make.bottom.equalTo(-16)
            make.centerX.equalToSuperview()
        }
        return label
    }()
    
    lazy var back: UIButton = {
        let button = UIButton(type: .custom)
        button.imageView?.tintColor = UIColor.white
        let image = UIImage(named: "arrow")?.withRenderingMode(.alwaysTemplate)
        button.setImage(image, for: .normal)
        navigationBar.addSubview(button)
        button.addTarget(self, action: #selector(pop), for: .touchUpInside)
        return button
    }()
    
    @objc func pop() {
        self.navigationController?.popViewController(animated: true)
    }
    
    override func viewSafeAreaInsetsDidChange() {
        self.view.layoutIfNeeded()
        navigationBar.snp.updateConstraints { make in
            make.left.top.right.equalToSuperview()
            make.height.equalTo(56 + view.safeAreaInsets.top)
        }
        back.snp.updateConstraints { make in
            make.bottom.equalTo(-16)
            make.left.equalTo(16 + view.safeAreaInsets.left)
        }
        var edges = view.safeAreaInsets
        edges.top += 56
        safeView.snp.updateConstraints { make in
            make.edges.equalTo(edges)
        }
    }
}

