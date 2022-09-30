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

    private var navi: UINavigationController!

    func setupFlutter(_ controller: FlutterViewController) {
        let navigation = UINavigationController(rootViewController: controller)
        navigation.setNavigationBarHidden(true, animated: false)
        window.rootViewController = navigation
        navi = navigation
        let flutterChannel = FlutterMethodChannel(name: "flutter.io", binaryMessenger: controller.binaryMessenger)
        flutterChannel.setMethodCallHandler { [unowned self] call, result in
            if call.method == "push_native" {
                guard let argv = call.arguments as? [Any] else {
                    return
                }
                pushNative(argv)
            } else if call.method == "method_js" {
                
            } else {
                result(FlutterMethodNotImplemented)
            }
        }
    }

    private func pushNative(_ argv: [Any]?) {
        guard let path = argv?.first as? String else {
            return
        }
        if path == "GameViewController" {
            let vc = GameViewController()
            if let param = argv?.last as? [String: Any],
               let lesson = param.toModel(Lesson.self) {
                vc.lesson = lesson
            }
            navi.pushViewController(vc, animated: true)
        }
    }
}
