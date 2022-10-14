import Flutter
import UIKit

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
    
    var navi: UINavigationController!

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
        
    }

   
}
