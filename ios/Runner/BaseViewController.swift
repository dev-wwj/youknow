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
//        navigationBar.backgroundColor =  UIColor(hexARGB: 0xFF03A9F4);
        view.backgroundColor = UIColor.randomLightish()
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
        label.textColor = UIColor.black
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
        button.imageView?.tintColor = UIColor.black
        let image = UIImage(named: "arrow")?.withRenderingMode(.alwaysTemplate)
        button.setImage(image, for: .normal)
        navigationBar.addSubview(button)
        button.addTarget(self, action: #selector(pop), for: .touchUpInside)
        return button
    }()
    
   private lazy var right: UIButton = {
        let button = UIButton(type: .custom)
        button.imageView?.tintColor = UIColor.black
        button.isHidden = true
//        let image = UIImage(named: "icon_grid")?.withRenderingMode(.alwaysTemplate)
//        button.setImage(image, for: .normal)
        navigationBar.addSubview(button)
        button.addTarget(self, action: #selector(rightAction), for: .touchUpInside)
        return button
    }()
    
    var rigthImage: String? {
        didSet {
            guard let name = rigthImage else {
                return
            }
            self.right.isHidden = false
            let image = UIImage(named: name)?.withRenderingMode(.alwaysTemplate)
            right.setImage(image, for: .normal)
        }
    }
    
    @objc func pop() {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc dynamic func rightAction() {
        
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
        right.snp.updateConstraints { make in
            make.bottom.equalTo(-16)
            make.right.equalTo(-16 - view.safeAreaInsets.right)
        }
        var edges = view.safeAreaInsets
        edges.top += 56
        safeView.snp.updateConstraints { make in
            make.edges.equalTo(edges)
        }
    }
}

