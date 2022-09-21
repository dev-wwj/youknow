import Flutter
import UIKit

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
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
        navigation.setNavigationBarHidden(true, animated: false)
        window.rootViewController = navigation
        let flutterChannel = FlutterMethodChannel(name: "flutter.io/push_native", binaryMessenger: controller.binaryMessenger)
        flutterChannel.setMethodCallHandler { call, result in
            if call.method == "push_native" {
                navigation.pushViewController(GameViewController(), animated: true)
            } else {
                result(FlutterMethodNotImplemented)
            }
        }
    }
}
