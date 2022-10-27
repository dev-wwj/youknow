//
//  GameViewController.swift
//  Runner
//
//  Created by wangwenjian on 2022/9/8.
//

import Flutter
import Foundation
import SnapKit
import UIKit
import WebKit

class GameViewController: BaseViewController {
    var myChars: MyChars?

    var images: [CellDate] = []

    var cacheProtocal: CacheProtocal?

    override func viewDidLoad() {
        super.viewDidLoad()
        automaticallyAdjustsScrollViewInsets = false
        setupCnChar()
        _ = drawing
        _ = pen
        _ = [save, clear]
        _ = charPicker
        cacheProtocal = DrawFileManager.manager
        rigthImage = "icon_grid"
    }

    var paths: [DPath]? {
        didSet {
            guard let paths = paths else {
                return
            }
            drawing.paths = paths
            drawing.setNeedsDisplay()
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }

    override func viewSafeAreaInsetsDidChange() {
        super.viewSafeAreaInsetsDidChange()
    }

    lazy var webView: WKWebView = {
        let preferences = WKPreferences()
        preferences.javaScriptCanOpenWindowsAutomatically = true
        preferences.setValue(true, forKey: "allowFileAccessFromFileURLs")
        let configuration = WKWebViewConfiguration()
        configuration.preferences = preferences
        let webView = WKWebView(frame: .zero, configuration: configuration)
        webView.allowsBackForwardNavigationGestures = false
        webView.navigationDelegate = self
        webView.backgroundColor = .clear
        webView.isOpaque = false
        webView.uiDelegate = self
        safeView.addSubview(webView)
        webView.snp.makeConstraints { make in
            make.top.left.equalTo(10)
            make.size.equalTo(CGSize(width: 140, height: 140))
        }
        return webView
    }()

    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 60, height: 60)
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = 8
        layout.minimumLineSpacing = 8
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.contentInset = UIEdgeInsets(top: 10, left: 16, bottom: 0, right: 15)
        collectionView.register(DrawedCell.self, forCellWithReuseIdentifier: "_cell")
        collectionView.backgroundColor = UIColor.clear
        collectionView.delegate = self
        collectionView.dataSource = self
        safeView.addSubview(collectionView)
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(webView)
            make.left.equalTo(webView.snp.right).offset(8)
            make.bottom.equalTo(webView)
            make.right.equalToSuperview().offset(-8)
        }
        return collectionView
    }()

    lazy var replay: UIButton = {
        let button = UIButton(type: .custom)
        button.addTarget(self, action: #selector(reloadWeb), for: .touchUpInside)
        safeView.addSubview(button)
        button.snp.makeConstraints { make in
            make.edges.equalTo(webView)
        }
        return button
    }()

    lazy var drawing: Drawing = {
        let drawing = Drawing(color: pen.pickedColor, lineWidth: pen.pickedWidth)
        drawing.backgroundColor = .clear
        safeView.addSubview(drawing)
        drawing.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.size.equalTo(CGSize(width: 320, height: 320))
        }
        return drawing
    }()

    lazy var pen: Pen = {
        let pen = Pen { [unowned self] _ in
        } didChange: { [unowned self] width, color in
            drawing.lineWidth = CGFloat(width)
            drawing.color = color
        }
        safeView.addSubview(pen)
        pen.snp.makeConstraints { make in
            make.right.equalTo(-16)
            make.bottom.equalTo(-16)
            make.size.equalTo(CGSize(width: 50, height: 50))
        }
        return pen
    }()

    lazy var save: UIButton = {
        let button = UIButton(type: .custom)
        button.imageView?.tintColor = UIColor.lightGray
        let image = UIImage(named: "favorite")?.withRenderingMode(.alwaysTemplate)
        button.setImage(image, for: .normal)
        button.tapAction(.touchUpInside) { [unowned self] _ in
            if drawing.isEmpty() {
                return
            }
            // 存储路径
            self.cacheProtocal?.addDPath(drawing.paths)

            if let img = drawing.snapshot() {
                images.append(CellDate(image: img, show: false))
                let indexPath = IndexPath(row: images.count - 1, section: 0)
                collectionView.insertItems(at: [indexPath])
                collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.25) { [weak self] in
                    self?.drawing.clear()
                    let attributes = self?.collectionView.layoutAttributesForItem(at: indexPath)
                    if let frame = attributes?.frame {
                        let rect = self?.collectionView.convert(frame, to: self?.safeView) ?? .zero
                        let imageView = UIImageView(image: img)
                        imageView.frame = self?.drawing.frame ?? .zero
                        self?.safeView.addSubview(imageView)
                        UIView.animate(withDuration: 0.25) {
                            imageView.frame = rect
                        } completion: { _ in
                            self?.images[indexPath.row].setShow()
                            let cell = self?.collectionView.cellForItem(at: indexPath) as! DrawedCell
                            cell.imageView.isHidden = false
                            imageView.removeFromSuperview()
                        }
                    }
                }
            }
        }
        safeView.addSubview(button)
        button.snp.makeConstraints { make in
            make.right.equalTo(drawing).offset(-20)
            make.top.equalTo(drawing.snp.bottom).offset(18)
        }
        return button
    }()

    lazy var clear: UIButton = {
        let button = UIButton(type: .custom)
        button.imageView?.tintColor = UIColor.lightGray
        let image = UIImage(named: "delete")?.withRenderingMode(.alwaysTemplate)
        button.setImage(image, for: .normal)
        button.tapAction(.touchUpInside) { [unowned self] _ in
            drawing.clear()
        }
        safeView.addSubview(button)
        button.snp.makeConstraints { make in
            make.right.equalTo(save.snp.left).offset(-8)
            make.top.equalTo(drawing.snp.bottom).offset(18)
        }
        return button
    }()

    lazy var charPicker: CharPickView = {
        let view = CharPickView(myChars: myChars!) { [weak self] index in
            self?.myChars?.index = index
            self?.reloadWeb()
        }
        navigationBar.addSubview(view)
        view.snp.makeConstraints { make in
            make.bottom.equalToSuperview()
            make.left.equalTo(60)
            make.right.equalTo(-60)
            make.height.equalTo(50)
        }
        return view
    }()
}

extension GameViewController {
    override func rightAction() {
        let vc = FlutterViewController(project: nil, initialRoute: "/draw", nibName: nil, bundle: nil)
        FlutterPlugin.instance.register(vc)
        navigationController?.pushViewController(vc, animated: true)
    }
}
