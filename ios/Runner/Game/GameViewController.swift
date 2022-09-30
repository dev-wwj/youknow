//
//  GameViewController.swift
//  Runner
//
//  Created by wangwenjian on 2022/9/8.
//

import Foundation
import UIKit
import SnapKit
import WebKit

class GameViewController: BaseViewController {
    
    var lesson: Lesson? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        _ = back
        setupCnChar()
        _ = drawing
        _ = pen
        JSTools.evaluateJavaScript("'拼音'.spell()")
        
        JSTools.evaluateJavaScript("cnchar.spellInfo('shàng')")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        showReader(false)
    }
    
    override func viewSafeAreaInsetsDidChange() {
        super.viewSafeAreaInsetsDidChange()
    }

    lazy var webView : WKWebView = {
        let preferences = WKPreferences()
        preferences.javaScriptCanOpenWindowsAutomatically = true
        preferences.setValue(true, forKey:"allowFileAccessFromFileURLs")
        let configuration = WKWebViewConfiguration()
        configuration.preferences = preferences
        let webView = WKWebView(frame: .zero, configuration: configuration)
        webView.allowsBackForwardNavigationGestures = false
        webView.navigationDelegate = self
        webView.uiDelegate = self
        webView.scrollView.isScrollEnabled = false
        safeView.addSubview(webView)
        webView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.size.equalTo(CGSize(width: 240, height: 240))
        }
        return webView
    }()
    
    lazy var drawing: Drawing = {
        let drawing = Drawing(color: pen.pickedColor, lineWidth: pen.pickedWidth)
        safeView.addSubview(drawing)
        drawing.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.size.equalTo(CGSize(width: 240, height: 240))
        }
        return drawing
    }()

    lazy var pen: Pen = {
        let pen = Pen() { [unowned self] isSelected in
            switchWriter()
        } didChange: {[unowned self] width, color in
            drawing.lineWidth = CGFloat(width)
            drawing.color = color
        }
        safeView.addSubview(pen)
        pen.snp.makeConstraints { make in
            make.right.equalTo(-10)
            make.bottom.equalTo(-10)
        }
        return pen
    }()
    
    lazy var back: UIButton = {
        let button = UIButton(type: .system)
        safeView.addSubview(button)
        button.addTarget(self, action: #selector(pop), for: .touchUpInside)
        button.setTitle("back", for: .normal)
        button.snp.makeConstraints { make in
            make.top.equalTo(15)
            make.left.equalTo(15)
        }
        return button
    }()
    
    @objc func pop() {
        self.navigationController?.popViewController(animated: true)
    }
}


extension GameViewController {
    func switchWriter(){
        if pen.isSelected {
            showWriter(true)
        } else {
            showReader(true)
        }
    }
    
    func showWriter(_ animate: Bool) {
        if animate {
            UIView.animate(withDuration: 0.25) { [unowned self] in
                drawing.transform = .identity
                drawing.alpha = 1.0
                webPutAside()
            } completion: { _ in
            }
        }else {
            drawing.transform = .identity
            drawing.alpha = 1.0
            webPutAside()
        }
    }
    
    func showReader(_ animate: Bool) {
        if animate {
            UIView.animate(withDuration: 0.25) { [unowned self] in
                drawingPackup()
                webView.transform = .identity
            } completion: { _ in
            }
        }else {
            drawingPackup()
            webView.transform = .identity
        }
    }
    
    private func drawingPackup() {
        let penCenter = pen.center
        let drawingCenter = drawing.center
        let trans = CGAffineTransform(translationX: penCenter.x - drawingCenter.x, y: penCenter.y - drawingCenter.y).scaledBy(x: 0.0, y: 0.0)
        drawing.transform =  trans
        drawing.alpha = 0.5
    }
    
    private func webPutAside () {
        let to = CGPoint(x: 60 , y: 120)
        let origin = webView.center
        let trans = CGAffineTransform(translationX: to.x - origin.x, y: to.y - origin.y).scaledBy(x: 0.4, y: 0.4)
        webView.transform = trans
    }
}
