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
        guard let method = argv.first as? String, let param = argv.last as? String else {
            return
        }
        switch method {
        case "applyingTransform":
            result(applyingTransform(param: param))
        case "speak":
            speak(param)
            break
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
    
    func speak( _ text: String){
        let utterance = AVSpeechUtterance(string: text )
        utterance.rate = AVSpeechUtteranceDefaultSpeechRate
        utterance.voice = self.synthesisVoice
        self.synthesizer.speak(utterance)
    }

}
