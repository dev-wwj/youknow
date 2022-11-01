//
//  FlutterChannel+method.swift
//  Runner
//
//  Created by wangwenjian on 2022/10/13.
//

import Foundation
import AVFoundation

extension FlutterPlugin {
    func nativeMethod(_ argv:[Any], result: @escaping FlutterResult) {
        guard let method = argv.first as? String, let param = argv.last else {
            return
        }
        switch method {
        case "applyingTransform":
            result(applyingTransform(param: param as! String))
        case "spelling0":
            spelling0(param as! String)
            break
        case "spelling1":
            spelling1(param as! String)
            break
        case "drawCount":
            result(drawCount())
            break
        case "byteAtIndex":
            guard let index = param as? Int else {
                return
            }
            result(imageDataAt(index))
        default:
            break
        }
    }
}

extension FlutterPlugin {
    // 字符串转拉丁字母 (汉字转拼音)
    private func applyingTransform(param: String) -> String {
        return param.applyingTransform(.toLatin, reverse: false) ?? ""
    }
    
    
    /// 女声播放
    /// - Parameter text: 播放内容
    func spelling0( _ text: String){
        /**
         AVSpeechUtterance
         .attributedString: 无法识别中文
         .string: 替换注音符号可以处理多音字 eg: 长 -> {zhang : ㄓㄤˇ, chang :ㄔㄤˊ}
         */
//        let attText = NSMutableAttributedString(string: "长", attributes: [.accessibilitySpeechIPANotation:"ㄓㄤˇ"])
//        let utterance = AVSpeechUtterance(attributedString:attText)
        
        let utterance = AVSpeechUtterance(string: text)
        utterance.rate = 0.3
        utterance.voice = self.femaleVoice
        self.synthesizer.speak(utterance)
    }
    
    
    /// 男声播放
    /// - Parameter text: 播放内容
    func spelling1( _ text: String){
        let utterance = AVSpeechUtterance(string: text)
        utterance.rate = 0.3
        utterance.voice = self.maleVoice
        self.synthesizer.speak(utterance)
    }
}

extension FlutterPlugin {
    func drawCount() -> Int{
        return DrawFileManager.manager.queryCount()
    }
    
    func imageDataAt(_ index: Int) -> [UInt8]? {
        guard let data =  DrawFileManager.manager.imageDataAt(index) else  {
            return nil
        }
        return [UInt8](data);
    }
}
