


import Foundation
import SwiftUI
import UserNotifications
import AppTrackingTransparency
import AdSupport
import AdServices
import OneSignalFramework
import AffiseAttributionLib
import Alamofire



extension Notification.Name {
    static let notifTracking = Notification.Name("notracColorRainbowFocus")
}

class AppDelegate: NSObject, UIApplicationDelegate {

    static var orientationLock = UIInterfaceOrientationMask.all

    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil) -> Bool {

        NotificationCenter.default.addObserver(self,
                                               selector: #selector(handleTrackingAuthorizationNotification(_:)),
                                               name: .notifTracking,
                                               object: nil)
       
        ServerLocalAs.shared.start()

        if let idfv = UIDevice.current.identifierForVendor?.uuidString {
            UserDefaults.standard.setValue(idfv, forKey: ConstLocalize.idfvID)
        }

        Task {
            if let fetchedToken = await AAAtrib() {
                for i in 1...2 {
                    try? await Task.sleep(nanoseconds: UInt64(Double(i) * 5 * 1_000_000_000))
                    if let response = await ASAATRcheck(token: fetchedToken) {
                        handleResponse(response)
                    }
                }
            }
        }

        initializeOneSignal(launchOptions: launchOptions)
        initializeAffise(application: application, launchOptions: launchOptions)
        return true
    }

    @objc private func handleTrackingAuthorizationNotification(_ notification: Notification) {
        requestNotificationPermiss()
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {}

    private func requestNotificationPermiss() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { granted, _ in
            if granted {
                UserDefaults.standard.set(true, forKey: "push_subscribe")
            }
        }
    }

    func application(_ application: UIApplication,
                     supportedInterfaceOrientationsFor window: UIWindow?) -> UIInterfaceOrientationMask {
        return AppDelegate.orientationLock
    }

    func application(_ application: UIApplication,
                     didReceiveRemoteNotification userInfo: [AnyHashable: Any],
                     fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {

        if let customOSPayload = userInfo["custom"] as? NSDictionary,
           let launchUrl = customOSPayload["u"] as? String,
           let url = URL(string: launchUrl) {
            guard let savedUrl = UserDefaults.standard.string(forKey: ConstLocalize.fullUrlSave), !savedUrl.isEmpty else {
                return
            }
            UserDefaults.standard.set(true, forKey: ConstLocalize.opFormPush)
            UIApplication.shared.open(url)
            ServiceEv.shared.sendEvent(eventName: "push_open_browser")
        } else {
            guard let savedUrl = UserDefaults.standard.string(forKey: ConstLocalize.fullUrlSave), !savedUrl.isEmpty else {
                return
            }
            UserDefaults.standard.set(true, forKey: ConstLocalize.opFormPush)
            ServiceEv.shared.sendEvent(eventName: "push_open_webview")
        }

        completionHandler(.newData)
    }

    private func initializeOneSignal(launchOptions: [UIApplication.LaunchOptionsKey: Any]?) {
        OneSignal.Debug.setLogLevel(.LL_VERBOSE)
        OneSignal.initialize("142984c1-ad15-484e-ac7b-8bedb9cc2f4a", withLaunchOptions: launchOptions)
    }
    func application(
        _ application: UIApplication,
        continue userActivity: NSUserActivity,
        restorationHandler: @escaping ([UIUserActivityRestoring]?) -> Void
    ) -> Bool {
        Affise.handleUserActivity(userActivity)
        return true
    }
    private func initializeAffise(application: UIApplication, launchOptions: [UIApplication.LaunchOptionsKey: Any]?) {
       
        Affise
            .settings(
                affiseAppId: "1305",
                secretKey: "b23382e8-57f7-40c8-91e9-85fb7c70883f"
            )
            .setProduction(true)
            .start(app: application, launchOptions: launchOptions)
        
        Affise.Module.moduleStart(.Advertising)

        let affiseUID = Affise.getRandomUserId()
        let deviceID = Affise.getRandomDeviceId()
        
       

        UserDefaults.standard.setValue(affiseUID, forKey: ConstLocalize.appsUID)
        UserDefaults.standard.setValue(deviceID, forKey: ConstLocalize.affiseDeviceID)
       
        DispatchQueue.main.asyncAfter(deadline: .now() + 5.5) {
            Affise.getReferrerUrl { referrer in
                
                if let url = referrer,
                   url.contains("sub1") || url.contains("sub2") {

                    let components = URLComponents(string: url)
                    let queryItems = components?.queryItems ?? []
                    let params = queryItems
                        .enumerated()
                        .compactMap { index, item -> String? in
                            guard let value = item.value else { return nil }
                            return "&\(ConstLocalize.subName)\(index + 1)=\(value)"
                        }
                        .joined()
                    

                    if UserDefaults.standard.object(forKey: "opColorRainbowFocus") == nil {
                        UserDefaults.standard.set(true, forKey: "opColorRainbowFocus")
                        UserDefaults.standard.setValue(params, forKey: ConstLocalize.namecampaign)
                    }
                }
             
            }
            
            
        }
       
       
    }
}

@MainActor
func handleResponse(_ response: String?) {
    guard let response = response, let data = response.data(using: .utf8) else { return }

    if let jsonObject = try? JSONSerialization.jsonObject(with: data, options: []),
       let dict = jsonObject as? [String: Any],
       let attribution = dict["attribution"] as? Bool {
        UserDefaults.standard.set(attribution, forKey: ConstLocalize.isASA)
    }
}

@MainActor
func ASAATRcheck(token: String) async -> String? {
    guard let url = URL(string: ConstLocalize.tokLcl) else { return nil }

    let parameters: [String: String] = ["token": token]
    let headers: HTTPHeaders = ["Content-Type": "application/json"]

    do {
        let data = try await AF.request(
            url,
            method: .post,
            parameters: parameters,
            encoding: JSONEncoding.default,
            headers: headers
        )
        .serializingData()
        .value

        return String(data: data, encoding: .utf8)
    } catch {
        return nil
    }
}

@MainActor
func AAAtrib() async -> String? {
    do {
        return try AAAttribution.attributionToken()
    } catch {
        return nil
    }
}

class ATTManager {
    static let shared = ATTManager()

    private init() {}

    func requestTrackingAuthorization() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            ATTrackingManager.requestTrackingAuthorization { status in
                switch status {
                case .authorized, .denied:
                    NotificationCenter.default.post(name: .notifTracking, object: nil)
                   
                case .restricted, .notDetermined:
                    self.requestTrackingAuthorization()
                @unknown default:
                    break
                }
            }
        }
    }
}
