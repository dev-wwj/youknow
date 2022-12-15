//
//  MyCanvasView.swift
//  Runner
//
//  Created by wangwenjian on 2022/12/12.
//

import Foundation
import PencilKit

class MyCanvasView: PKCanvasView {
    
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        // border
        0xD0D0D0.color?.set()
        borderPath.stroke()
        //米
//        UIColor.lightGray.set()
        miPath.stroke()
    }
    
    private lazy var borderPath: UIBezierPath = {
        let path = UIBezierPath()
        path.move(to: CGPoint(x: 0, y: 0))
        path.addLine(to: CGPoint(x: self.bounds.width, y: 0))
        path.addLine(to: CGPoint(x: self.bounds.width, y: self.bounds.height))
        path.addLine(to: CGPoint(x: 0, y: self.bounds.height))
        path.lineWidth = 2
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
        path.lineWidth = 1
        path.lineJoinStyle = .bevel
        path.lineCapStyle = .square
        return path
    }()
}
