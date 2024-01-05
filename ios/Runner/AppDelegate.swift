import Flutter
import UIKit

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
    
    var navi: UINavigationController!
    var eventSink:FlutterEventSink? = nil

    override func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        URLProtocol.registerClass(RNCachingURLProtocol.self)

        guard let controller = window?.rootViewController as? FlutterViewController else {
            fatalError("contoller is not type FlutterViewController")
        }
        GeneratedPluginRegistrant.register(with: self)
        setupFlutter(controller)
        return super.application(application, didFinishLaunchingWithOptions: launchOptions)
    }


    func setupFlutter(_ controller: FlutterViewController) {
        let navigation = UINavigationController(rootViewController: controller)
        navigation.navigationBar.isHidden = true
        window.rootViewController = navigation
        navi = navigation
        FlutterPlugin.instance.register(controller)
        
        if let messager = controller as? FlutterBinaryMessenger {
            let channel = FlutterEventChannel(name: "com.push.data", binaryMessenger: messager)
            channel.setStreamHandler(self)
        }
    }
}

extension AppDelegate: FlutterStreamHandler {
    func onListen(withArguments arguments: Any?, eventSink events: @escaping FlutterEventSink) -> FlutterError? {
        eventSink = events
        return nil
    }
    
    func onCancel(withArguments arguments: Any?) -> FlutterError? {
        return nil
    }
}


extension AppDelegate {
    override func applicationWillTerminate(_ application: UIApplication) {
        DrawFileManager.saveFiles()
    }
}
