//
//  PencilVC.swift
//  Runner
//
//  Created by wangwenjian on 2022/12/1.
//

import Foundation
import UIKit
import PencilKit
import WebKit

class HandwritingVC: BaseViewController {
    
    var myChars: MyChars!
    let cache = DrawedCache.cache
    override func viewDidLoad() {
        super.viewDidLoad()
        rigthImage = "folder"
        _ = charPicker
        _ = writingView
        _ = canvasView
        _ = handleView
        _ = toolPicker
        self.canvasView.drawing =  self.cache.model.draweds.last?.drawing ?? PKDrawing()
    }
    
    lazy var charPicker: CharPickView = {
        let view = CharPickView(myChars: myChars!) { [weak self] index in
            self?.myChars?.index = index
            self?.writingView.writerView.char = self?.myChars.char
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
    
    lazy var writingView: WritingView = {
        let view = WritingView()
        safeView.addSubview(view)
        return view
    }()
    
    lazy var canvasView: MyCanvasView = {
        let canvas = MyCanvasView()
        canvas.delegate = self
        canvas.isOpaque = false
        if #available(iOS 14.0, *) {
            canvas.drawingPolicy = .anyInput
        } else {
            // Fallback on earlier versions
        }
        canvas.drawing = PKDrawing()
        safeView.addSubview(canvas)
        return canvas
    }()
    
    lazy var toolPicker: PKToolPicker = {
        var toolPicker: PKToolPicker!
        if #available(iOS 14.0, *) {
            toolPicker = PKToolPicker()
        } else {
            toolPicker = PKToolPicker.shared(for: self.view.window!)
            // Fallback on earlier versions
        }
        toolPicker.selectedTool = PKInkingTool(.pencil, color: .blue, width: 10)
        toolPicker.addObserver(canvasView)
        toolPicker.setVisible(true, forFirstResponder: handleView.pencil)
        return toolPicker
    }()
    
    lazy var handleView: WriterHandleView = {
        let handleView = WriterHandleView()
        handleView.delegate = self
        safeView.addSubview(handleView)
        return handleView
    }()
    
    override func viewSafeAreaInsetsDidChange() {
        super.viewSafeAreaInsetsDidChange()
        let orientation = UIDevice.current.orientation
        if [UIDeviceOrientation.landscapeLeft, UIDeviceOrientation.landscapeRight].contains(orientation) {
            //horizontally
            writingView.snp.remakeConstraints { make in
                make.left.equalTo(15)
                make.top.equalTo(15)
                make.width.equalTo(140)
                make.bottom.equalTo(-15)
            }
            canvasView.snp.remakeConstraints { make in
                make.center.equalToSuperview()
                make.size.equalTo(CGSize(width: minorSafeWH - 30, height: minorSafeWH - 30))
            }
            handleView.snp.remakeConstraints { make in
                make.left.equalTo(canvasView.snp.right).offset(15)
                make.top.equalTo(canvasView)
                make.size.equalTo(CGSize(width: 50, height: 262))
            }
        }else {
            //vertically
            writingView.snp.remakeConstraints { make in
                make.left.equalTo(15)
                make.right.equalTo(-15)
                make.top.equalTo(15)
                make.height.equalTo(140)
            }
            canvasView.snp.remakeConstraints { make in
                make.center.equalToSuperview()
                make.size.equalTo(CGSize(width: minorSafeWH - 30, height: minorSafeWH - 30))
            }
            handleView.snp.remakeConstraints { make in
                make.left.equalTo(canvasView)
                make.top.equalTo(canvasView.snp.bottom).offset(15)
                make.size.equalTo(CGSize(width: 262, height: 50))
            }
        }
    }
}

extension HandwritingVC {
    override func rightAction() {
        let vc = FlutterViewController(project: nil, initialRoute: "/draw", nibName: nil, bundle: nil)
        FlutterPlugin.instance.register(vc)
        navigationController?.pushViewController(vc, animated: true)
    }
}


extension HandwritingVC: PKCanvasViewDelegate {
    func canvasViewDrawingDidChange(_ canvasView: PKCanvasView) {
        
    }
    
    func canvasViewDidBeginUsingTool(_ canvasView: PKCanvasView) {
        canvasView.becomeFirstResponder()
    }
    
    func canvasViewDidFinishRendering(_ canvasView: PKCanvasView) {
        
    }
    
    func canvasViewDidEndUsingTool(_ canvasView: PKCanvasView) {
    }
}

extension HandwritingVC: WriterHandleDelegate {
    func writerHandle(_ view: WriterHandleView, actionType: WriterHandleAction) {
        switch actionType {
        case .undo:
            canvasView.undoManager?.undo()
        case .redo:
            canvasView.undoManager?.redo()
        case .refresh:
            canvasView.drawing = PKDrawing()
        case .pencil:
            break
        case .favorite:
            let drawing = canvasView.drawing
            cache.addDrawing(drawing, size: canvasView.bounds.size)
            let img = canvasView.drawing.image(from: canvasView.bounds, scale: 1.0)
            let data = CellData(image: img, show: false)
            writingView.addImage(data, animateBase: canvasView)
            canvasView.drawing = PKDrawing()
        }
    }
    
    
}
