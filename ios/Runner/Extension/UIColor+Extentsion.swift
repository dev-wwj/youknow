//
//  UIColorExtentsion.swift
//  HappyScholar
//
//  Created by xox on 2019/12/24.
//  Copyright © 2019 xox. All rights reserved.
//

import Foundation
import UIKit
@objc extension UIColor{
    convenience init(hex:Int) {
        self.init(hex:hex,alpha:1.0)
    }
    convenience init(hex:Int, alpha:Float){
        let rInt = (hex & 0xFF0000) >> 16
        let r = CGFloat(rInt) / 255.0;
        
        let gInt = (hex & 0xFF00) >> 8
        let g = CGFloat(gInt)   / 255.0
        
        let bInt = (hex & 0xFF)
        let b = CGFloat(bInt) / 255.0
        self.init(red: r, green: g, blue: b, alpha: CGFloat(alpha))
    }
    
    convenience init(hexA:Int){
        let rInt = (hexA & 0xFF000000) >> 24
        let r = CGFloat(rInt) / 255.0;
        
        let gInt = (hexA & 0xFF0000) >> 16
        let g = CGFloat(gInt)   / 255.0
        
        let bInt = (hexA & 0xFF00) >> 8
        let b = CGFloat(bInt) / 255.0
        
        let aInt = (hexA & 0xFF)
        let a = CGFloat(aInt) / 255.0
        self.init(red: r, green: g, blue: b, alpha: a)
    }
    //16进制颜色
    @objc static func _Color(hex:Int) -> UIColor{
        return UIColor(hex:hex)
    }
    public var hexString: String {
        var red: CGFloat = 0
        var green: CGFloat = 0
        var blue: CGFloat = 0
        var alpha: CGFloat = 0
        let multiplier = CGFloat(255.999999)
        guard self.getRed(&red, green: &green, blue: &blue, alpha: &alpha) else {
            return "#000000"
        }
        if alpha == 1.0 {
            return String(
                format: "#%02lX%02lX%02lX",
                Int(red * multiplier),
                Int(green * multiplier),
                Int(blue * multiplier)
            )
        }
        else {
            return String(
                format: "#%02lX%02lX%02lX%02lX",
                Int(red * multiplier),
                Int(green * multiplier),
                Int(blue * multiplier),
                Int(alpha * multiplier)
            )
        }
    }

    public var r: CGFloat {
        var red: CGFloat = 0
        guard self.getRed(&red, green: nil, blue: nil, alpha: nil) else {
            return 0.0
        }
        return red
    }
    public var g: CGFloat {
        var green: CGFloat = 0
        guard self.getRed(nil, green: &green, blue: nil, alpha: nil) else {
            return 0.0
        }
        return green
    }
    public var b: CGFloat {
        var blue: CGFloat = 0
        guard self.getRed(nil, green: nil, blue: &blue, alpha: nil) else {
            return 0.0
        }
        return blue
    }
//    public var alpha: CGFloat {
//        var alpha: CGFloat = 0
//        guard self.getRed(nil, green: nil, blue: nil, alpha: &alpha) else {
//            return 0.0
//        }
//        return alpha
//    }
    public var hexA: Double {
        var red: CGFloat = 0
        var green: CGFloat = 0
        var blue: CGFloat = 0
        var alpha: CGFloat = 0
        guard self.getRed(&red, green: &green, blue: &blue, alpha: &alpha) else {
            return 0x00000000
        }
        let r = Int(red * 255) << 24
        let g = Int(green * 255) << 16
        let b = Int(blue * 255) << 8
        let a = Int(alpha * 255)
        
        return Double(r + g + b + a)
    }
    
    public func alpha(_ a: CGFloat) -> UIColor {
         return self.withAlphaComponent(a)
    }
    
    static func randomColor() -> UIColor {
        return UIColor.init(red: CGFloat(arc4random()%255)/255, green: CGFloat(arc4random()%255)/255, blue: CGFloat(arc4random()%255)/255, alpha: 1.0)
    }
}
extension String {
    public var color: UIColor? {
        let reg = "^(#|0x|0X){0,1}[0-9A-Fa-f]{6}$"
        guard self.range(of: reg, options: .regularExpression, range: nil, locale: nil) != nil else {
            return nil
        }
        var hexString = self;
        if self.count == 7 {
            hexString = String(hexString[self.index(after: self.startIndex)..<self.endIndex])
        }else if self.count == 8 {
            hexString = String(hexString[self.index(self.startIndex, offsetBy: 2)..<self.endIndex])
        }
        
        let scanner = Scanner(string: hexString)
        var color: UInt32 = 0
        scanner.scanHexInt32(&color)
        
        let mask = 0x000000FF
        let r = Int(color >> 16) & mask
        let g = Int(color >> 8) & mask
        let b = Int(color) & mask
        
        let red   = CGFloat(r) / 255.0
        let green = CGFloat(g) / 255.0
        let blue  = CGFloat(b) / 255.0
        
        return UIColor(red: red, green: green, blue: blue, alpha: 1)
        
    }
    public var cgColor: CGColor? {
        return self.color?.cgColor
    }
}
