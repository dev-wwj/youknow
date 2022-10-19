//
//  FlutterHandler.swift
//  Runner
//
//  Created by wangwenjian on 2022/10/13.
//

import Foundation
import Flutter
import AVFoundation

class FlutterPlugin {
    static let instance = FlutterPlugin()
    
    var navi: UINavigationController? {
        get {
            guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
                return nil
            }
            return appDelegate.navi
        }
    }
    
    lazy var synthesisVoice: AVSpeechSynthesisVoice? = {
        //let voice = AVSpeechSynthesisVoice(identifier: "com.apple.ttsbundle.siri_female_zh-CN_compact")
        let voice = AVSpeechSynthesisVoice(identifier: "com.apple.ttsbundle.siri_male_zh-CN_compact")
        //let voice = AVSpeechSynthesisVoice(language: "zh-CN")
        return voice
    }()
    
    lazy var synthesizer: AVSpeechSynthesizer = {
        let synthesizer = AVSpeechSynthesizer()
        return synthesizer
    }()

}

extension FlutterPlugin {
    
    func register(_ controller: FlutterViewController) {
        let flutterChannel = FlutterMethodChannel(name: "flutter.io", binaryMessenger: controller.binaryMessenger)
        flutterChannel.setMethodCallHandler { [unowned self] call, result in
            if call.method == keyRouteNative {
                guard let argv = call.arguments as? [Any] else {
                    return
                }
                nativeRoute(argv)
            } else if call.method == keyMethodNative {
                guard let argv = call.arguments as? [Any] else {
                    return
                }
                nativeMethod(argv, result: result)
            } else if call.method == "method_js" {
                
            } else {
                result(FlutterMethodNotImplemented)
            }
        }
    }
}
