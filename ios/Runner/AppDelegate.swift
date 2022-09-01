import UIKit
import Flutter
import FirebaseCore

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
    
    private lazy var channel = {
        FlutterMethodChannel(
            name: "mobilesdk",
            binaryMessenger: self.flutterController.binaryMessenger
        )
    }()
    
    private var flutterController: FlutterViewController {
        self.window?.rootViewController as! FlutterViewController
    }

    override func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        FirebaseApp.configure()
        GeneratedPluginRegistrant.register(with: self)
        channel.setMethodCallHandler(self.handleMethodInvocation)
        return super.application(application, didFinishLaunchingWithOptions: launchOptions)
    }
    
    // MARK: - Handler
    /// Main handler for method invocation
    /// - Parameters:
    ///   - call: call information
    ///   - result: result triggerer
    func handleMethodInvocation(
        _ call: FlutterMethodCall,
        result: @escaping FlutterResult
    ) {
        guard let method: GeneratedFlutterVerifytPlatformSDK = GeneratedFlutterVerifytPlatformSDK(rawValue: call.method) else {
            fatalError("\(#function) unknown method \(call.method) does not match any types defined in GeneratedFlutterVerifytPlatformSDK")
        }
        guard let arguments: [String: Any] = (call.arguments ?? [:]) as? [String: Any] else {
            fatalError("\(#function) missing arguments")
        }
        debugPrint("\(#file)::\(#function) - call: \(call.method)")

        switch method {
        case .VALIDATE_ANSWER:
            let didMobileWin: Bool = arguments["didMobileWin"] as! Bool
            
            if didMobileWin {
                result(true)
            } else {
                fatalError("cannot be, winner is mobile")
            }
            
        default: break
        }
    }
}



