//
//  Drawing.swift
//  Runner
//
//  Created by wangwenjian on 2022/9/8.
//

import Foundation
import UIKit


class DPath: NSObject, NSCoding {
    
    func encode(with coder: NSCoder) {
        coder.encode(path, forKey: "path")
        coder.encode(color, forKey: "color")
        coder.encode(lineWidth, forKey: "lineWidth")
    }
    
    required init?(coder: NSCoder) {
        path = coder.decodeObject(forKey: "path") as! UIBezierPath
        color = coder.decodeObject(forKey: "color") as! UIColor
        lineWidth = coder.decodeObject(forKey: "lineWidth") as! CGFloat
    }
    
    var path: UIBezierPath
    let color: UIColor
    let lineWidth: CGFloat
    
    init(path: UIBezierPath, color: UIColor, lineWidth: CGFloat) {
        self.path = path
        self.color = color
        self.lineWidth = lineWidth
    }
}

class Drawing: UIView  {
    
    var paths: [DPath] = []
    
    var color: UIColor?
    var lineWidth: CGFloat?
    convenience init(color: UIColor, lineWidth: CGFloat) {
        self.init(frame: .zero)
        self.color = color
        self.lineWidth = lineWidth
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func clear(){
        paths.removeAll()
        setNeedsDisplay()
    }
    
    func isEmpty() ->Bool {
        return self.paths.count == 0
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.randomElement()
        guard let point = touch?.location(in: self) else {
            fatalError("Touch begin invalid")
        }
        let path = UIBezierPath()
        path.move(to: point)
        paths.append(DPath(path: path, color: color ?? UIColor.black,  lineWidth: lineWidth ?? 1))
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.randomElement()
        guard let point = touch?.location(in: self) else {
            fatalError("Touch Move invalid")
        }
        guard let path = self.paths.last else {
            fatalError("Path invalid")
        }
        path.path.addLine(to: point)
        self.setNeedsDisplay()
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.randomElement()
        guard let point = touch?.location(in: self) else {
            fatalError("Touch Move invalid")
        }
        guard let path = self.paths.last else {
            fatalError("Path invalid")
        }
        path.path.addLine(to: point)
        self.setNeedsDisplay()
    }
     
    override func draw(_ rect: CGRect) {
        // border
        UIColor.lightGray.set()
        borderPath.stroke()
        //米
        UIColor.lightGray.set()
        miPath.stroke()
        
        paths.forEach { path in
            path.color.set()
            path.path.lineWidth = path.lineWidth
            path.path.lineJoinStyle = .round
            path.path.lineCapStyle = .round
            path.path.stroke()
        }
    }
    
    private lazy var borderPath: UIBezierPath = {
        let path = UIBezierPath()
        path.move(to: CGPoint(x: 0, y: 0))
        path.addLine(to: CGPoint(x: self.bounds.width, y: 0))
        path.addLine(to: CGPoint(x: self.bounds.width, y: self.bounds.height))
        path.addLine(to: CGPoint(x: 0, y: self.bounds.height))
        path.lineWidth = 4
        path.lineJoinStyle = .bevel
        path.lineCapStyle = .square
        path.close()
        return path
    }()
    
    private lazy var miPath: UIBezierPath = {
        let path = UIBezierPath()
        path.move(to: CGPoint(x: 0, y:  self.bounds.height/2))
        path.addLine(to: CGPoint(x: self.bounds.width, y: self.bounds.height/2))
        path.move(to: CGPoint(x: self.bounds.width/2, y: 0))
        path.addLine(to: CGPoint(x: self.bounds.width/2, y: self.bounds.height))
        path.move(to: CGPoint(x: 0, y: 0))
        path.addLine(to: CGPoint(x: self.bounds.width, y: self.bounds.height))
        path.move(to: CGPoint(x: 0, y: self.bounds.height))
        path.addLine(to: CGPoint(x: self.bounds.width, y: 0))
        path.setLineDash([10], count: 1, phase: 4)
        path.lineWidth = 2
        path.lineJoinStyle = .bevel
        path.lineCapStyle = .square
        return path
    }()
    
}
