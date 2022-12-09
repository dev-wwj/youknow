//
//  WriterHandleView.swift
//  Runner
//
//  Created by wangwenjian on 2022/12/5.
//

import Foundation

enum WriterHandleAction {
    case undo
    case redo
    case refresh
    case pencil
    case favorite
}

protocol WriterHandleDelegate {
    func writerHandle(_ view: WriterHandleView, actionType: WriterHandleAction)
}

class WriterHandleView: UIView {
    
    
    var delegate: WriterHandleDelegate? = nil
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        _ = stackView
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
  
    lazy var stackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews:
                                    [undo, redo, refresh, favorite, pencil])
        stack.spacing = 3
        stack.axis = .vertical
        stack.distribution = .fillEqually
        addSubview(stack)
        stack.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        return stack
    }()
    
    lazy var undo: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: "undo"), for: .normal)
        button.tapAction(.touchUpInside) {[unowned self] _ in
            self.delegate?.writerHandle(self, actionType: .undo)
        }
        return button
    }()
    
    lazy var redo: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: "redo"), for: .normal)
        button.tapAction(.touchUpInside) {[unowned self] _ in
            self.delegate?.writerHandle(self, actionType: .redo)
        }
        return button
    }()
    
    lazy var refresh: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: "refresh"), for: .normal)
        button.tapAction(.touchUpInside) {[unowned self] _ in
            self.delegate?.writerHandle(self, actionType: .refresh)
        }
        return button
    }()
    
    lazy var pencil: ResponderButton = {
        let button = ResponderButton(type: .system)
        button.setImage(UIImage(named: "pencil"), for: .normal)
        button.tapAction(.touchUpInside) {[unowned self] btn in
            btn.becomeFirstResponder()
            self.delegate?.writerHandle(self, actionType: .pencil)
        }
        return button
    }()
    
    lazy var favorite: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: "favorite"), for: .normal)
        button.tapAction(.touchUpInside) {[unowned self] _ in
            self.delegate?.writerHandle(self, actionType: .favorite)
        }
        return button
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        if [UIDeviceOrientation.landscapeLeft,
            UIDeviceOrientation.landscapeRight]
            .contains(UIDevice.current.orientation) {
            stackView.axis = .vertical
        } else {
            stackView.axis = .horizontal
        }
    }
}

class ResponderButton: UIButton {
    override var canBecomeFirstResponder: Bool{
        return true
    }
}
