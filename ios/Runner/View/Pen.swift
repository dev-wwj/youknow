//
//  Pen.swift
//  Runner
//
//  Created by wangwenjian on 2022/9/8.
//

import AMPopTip
import Foundation
import UIKit

let kUserDefaultPenColor = "kUserDefaultPenColor"
let kUserDefaultPenWidth = "kUserDefaultPenWidth"

class Pen: UIControl {
    private var showTool: Bool = false

    static var defaultPenColor: Double {
        guard let color = UserDefaults.standard.object(forKey: kUserDefaultPenColor) as? Double else {
            return ColorsBar.colors.first!.hexA
        }
        return color
    }

    static var defaultPenWith: CGFloat {
        guard let width = UserDefaults.standard.object(forKey: kUserDefaultPenWidth) as? CGFloat else {
            return 2
        }
        return width
    }

    var pickedColor: UIColor = UIColor(hexA: Int(defaultPenColor)) {
        willSet {
            if newValue == pickedColor {
                return
            }
            shapeLayer.strokeColor = newValue.cgColor
            didChange(pickedWidth, newValue)
            UserDefaults.standard.set(newValue.hexA, forKey: kUserDefaultPenColor)
        }
    }

    var pickedWidth: CGFloat = defaultPenWith {
        willSet {
            if newValue == pickedWidth {
                return
            }
            shapeLayer.lineWidth = newValue
            didChange(newValue, pickedColor)
            UserDefaults.standard.set(newValue, forKey: kUserDefaultPenWidth)
        }
    }
    
    override var isHighlighted: Bool {
        didSet {
            if isHighlighted {
                layer.borderColor = UIColor.black.cgColor
                imageView.tintColor = UIColor.black
            } else {
                layer.borderColor = UIColor.lightGray.cgColor
                imageView.tintColor = UIColor.lightGray
            }
        }
    }

    override var isSelected: Bool {
        didSet {
            if oldValue == isSelected {
                return
            }
            didSelected(isSelected)
        }
    }

    private var didSelected: ((Bool) -> Void)!

    private var didChange: ((CGFloat, UIColor) -> Void)!

    convenience init(didSelected: ((Bool) -> Void)!, didChange: ((CGFloat, UIColor) -> Void)!) {
        self.init(frame: .zero)
        self.didSelected = didSelected
        self.didChange = didChange
        layer.borderColor = UIColor.lightGray.cgColor
        layer.borderWidth = 2
        layer.cornerRadius = 5
        _ = shapeLayer
        _ = imageView
        tapAction(.touchUpInside) { [unowned self] _ in
            if showTool {
                chirographyBar.disMiss()
                colorsBar.disMiss()
            } else {
                chirographyBar.show(onView: self)
                colorsBar.show(onView: self)
            }
            showTool = !showTool
        }
    }

    private lazy var chirographyBar: ChirographyBar = {
        let chirographyBar = ChirographyBar { [unowned self] lineWidth in
            self.pickedWidth = lineWidth
        }
        return chirographyBar
    }()

    private lazy var colorsBar: ColorsBar = {
        let colorsBar = ColorsBar { [unowned self] color in
            self.pickedColor = color
            chirographyBar.tintColor = color
        }
        return colorsBar
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    lazy var imageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "pen")?.withRenderingMode(.alwaysTemplate))
        imageView.tintColor = UIColor.lightGray
        addSubview(imageView)
        imageView.snp.makeConstraints { make in
            make.edges.equalTo(UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5))
        }
        return imageView
    }()

    private lazy var shapeLayer: CAShapeLayer = {
        let layer = CAShapeLayer()
        layer.fillColor = UIColor.clear.cgColor
        layer.strokeColor = pickedColor.cgColor
        layer.path = paintPath.cgPath
        layer.lineWidth = Pen.defaultPenWith
        layer.lineCap = .butt
        self.layer.addSublayer(layer)
        return layer
    }()

    private lazy var paintPath: UIBezierPath = {
        let bezierPath = UIBezierPath()
        bezierPath.move(to: CGPoint(x: 10, y: 40))
        bezierPath.addCurve(to: CGPoint(x: 40, y: 40), controlPoint1: CGPoint(x: 24, y: 50), controlPoint2: CGPoint(x: 32, y: 30))
        return bezierPath
    }()
}

class ChirographyBar: UIView, UIPopoverPresentationControllerDelegate {
    var checkedBlock: ((CGFloat) -> Void)?
    convenience init(checkedBlock: ((CGFloat) -> Void)? = nil) {
        self.init(frame: CGRect(x: 0, y: 0, width: 40, height: 43 * 6))
        self.checkedBlock = checkedBlock
    }

    public func show(onView: UIView) {
        popTip.show(customView: self, direction: .up, in: onView.superview!, from: onView.frame)
    }

    public func disMiss() {
        popTip.hide(forced: true)
    }

    lazy var popTip: PopTip = {
        let popTip = PopTip()
        popTip.shouldDismissOnTapOutside = false
        popTip.shouldDismissOnTap = false
        popTip.bubbleColor = .lightGray
        popTip.padding = 2
        return popTip
    }()

    var stackView: UIStackView!
    var menus: [Chirography] = []

    override var tintColor: UIColor? {
        didSet {
            menus.forEach { view in
                view.tintColor = tintColor
            }
        }
    }

    private let fontWidths = [2.0, 4.0, 6.0, 8.0, 10.0, 12.0]
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        fontWidths.forEach { value in
            let view = Chirography(frame: .zero, width: CGFloat(value), color: UIColor(hexA: Int(Pen.defaultPenColor)))
            view.tapAction(.touchDown) { [unowned self] control in
                self.itemTap(control as! Chirography)
            }
            if Pen.defaultPenWith == value {
                view.isSelected = true
            }
            menus.append(view)
        }
        stackView = UIStackView(arrangedSubviews: menus)
        stackView.axis = .vertical
        stackView.spacing = 3
        stackView.distribution = .fillEqually
        stackView.frame = frame
        addSubview(stackView)
    }

    func itemTap(_ view: Chirography) {
        menus.forEach { view in
            view.isSelected = false
        }
        let index = menus.firstIndex(of: view) ?? 0
        checkedBlock?(fontWidths[index])
        view.isSelected = true
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class Chirography: UIControl {
    let width: CGFloat

    override var tintColor: UIColor! {
        didSet {
            shapeLayer.strokeColor = tintColor.cgColor
            self.layer.borderColor = isSelected ? tintColor.cgColor : UIColor.white.cgColor
        }
    }

    override var isSelected: Bool {
        willSet {
            if newValue == isSelected {
                return
            }
            if newValue {
                layer.borderColor = tintColor.cgColor
            } else {
                layer.borderColor = UIColor.white.cgColor
            }
        }
    }

    init(frame: CGRect, width: CGFloat, color: UIColor) {
        self.width = width
        super.init(frame: frame)
        backgroundColor = .white
        layer.cornerRadius = 5
        layer.borderWidth = 2
        layer.borderColor = UIColor.white.cgColor
        tintColor = color
        _ = shapeLayer
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private lazy var shapeLayer: CAShapeLayer = {
        let layer = CAShapeLayer()
        layer.fillColor = UIColor.clear.cgColor
        layer.strokeColor = tintColor.cgColor
        layer.path = paintPath.cgPath
        layer.lineWidth = width
        layer.lineCap = .butt
        self.layer.addSublayer(layer)
        return layer
    }()

    private lazy var paintPath: UIBezierPath = {
        let bezierPath = UIBezierPath()
        bezierPath.move(to: CGPoint(x: 10, y: 10))
        bezierPath.addCurve(to: CGPoint(x: 30, y: 30), controlPoint1: CGPoint(x: 0, y: 20), controlPoint2: CGPoint(x: 50, y: 30))
        return bezierPath
    }()
}

class ColorsBar: UIView, UIPopoverPresentationControllerDelegate {
    static let colors = [UIColor.black, UIColor.red, UIColor.blue, UIColor.yellow, UIColor.green, UIColor.purple]

    var checkedBlock: ((UIColor) -> Void)?
    convenience init(checkedBlock: ((UIColor) -> Void)? = nil) {
        self.init(frame: CGRect(x: 0, y: 0, width: 43 * 6, height: 40))
        self.checkedBlock = checkedBlock
    }

    public func show(onView: UIView) {
        popTip.show(customView: self, direction: .left, in: onView.superview!, from: onView.frame)
    }

    public func disMiss() {
        popTip.hide(forced: true)
    }

    lazy var popTip: PopTip = {
        let popTip = PopTip()
        popTip.shouldDismissOnTapOutside = false
        popTip.shouldDismissOnTap = false
        popTip.bubbleColor = .lightGray
        popTip.padding = 2
        return popTip
    }()

    var radios: [RadioColor] = []
    var stackView: UIStackView!
    override init(frame: CGRect) {
        super.init(frame: frame)
        ColorsBar.colors.forEach { value in
            let view = RadioColor(frame: CGRect(x: 0, y: 0, width: 40, height: 40), color: value)
            view.tapAction(.touchDown) { [unowned self] view in
                self.itemTap(view as! RadioColor)
            }
            if value.hexA == Pen.defaultPenColor {
                view.isSelected = true
            }
            radios.append(view)
        }
        stackView = UIStackView(arrangedSubviews: radios)
        stackView.axis = .horizontal
        stackView.spacing = 3
        stackView.distribution = .fillEqually
        stackView.frame = bounds
        addSubview(stackView)
    }

    func itemTap(_ view: RadioColor) {
        radios.forEach { view in
            view.isSelected = false
        }
        view.isSelected = true
        checkedBlock?(view.color)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class RadioColor: UIControl {
    var color: UIColor {
        didSet {
            shapeLayer.strokeColor = color.cgColor
        }
    }

    override var isSelected: Bool {
        willSet {
            if newValue == isSelected {
                return
            }
            if newValue {
                layer.borderColor = color.cgColor
            } else {
                layer.borderColor = UIColor.white.cgColor
            }
        }
    }

    init(frame: CGRect, color: UIColor) {
        self.color = color
        super.init(frame: frame)
        backgroundColor = .white
        layer.cornerRadius = 5
        layer.borderWidth = 2
        layer.borderColor = UIColor.white.cgColor
        _ = shapeLayer
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private lazy var shapeLayer: CAShapeLayer = {
        let layer = CAShapeLayer()
        layer.fillColor = color.cgColor
        layer.strokeColor = color.cgColor
        layer.path = bezierPath.cgPath
        self.layer.addSublayer(layer)
        return layer
    }()

    private lazy var bezierPath: UIBezierPath = {
        let bezierPath = UIBezierPath(arcCenter: CGPoint(x: self.bounds.midY, y: self.bounds.midY), radius: 10, startAngle: 0, endAngle: .pi * 2, clockwise: true)
        return bezierPath
    }()
}
