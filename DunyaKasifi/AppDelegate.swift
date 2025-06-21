import UIKit
import Firebase
import CoreData
import UserNotifications

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "DunyaKasifi")
        container.loadPersistentStores { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        }
        return container
    }()

    func saveContext() {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        FirebaseApp.configure()
        setupPushNotifications(application: application)
        configureAppAppearance()
        return true
    }

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
    }

    func setupPushNotifications(application: UIApplication) {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { granted, error in
            if granted {
                DispatchQueue.main.async {
                    application.registerForRemoteNotifications()
                }
            }
        }
    }

    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        Messaging.messaging().apnsToken = deviceToken
    }

    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        print("Failed to register for remote notifications with error: \(error.localizedDescription)")
    }

    func configureAppAppearance() {
        UINavigationBar.appearance().barTintColor = UIColor.systemBlue
        UINavigationBar.appearance().tintColor = UIColor.white
        UIBarButtonItem.appearance().tintColor = UIColor.white
        UISegmentedControl.appearance().selectedSegmentTintColor = UIColor.systemGreen
        UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor: UIColor.white], for: .normal)
    }

    func applicationWillResignActive(_ application: UIApplication) {
        saveContext()
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        saveContext()
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
    }

    func applicationWillTerminate(_ application: UIApplication) {
        saveContext()
    }

    func application(_ application: UIApplication, open url: URL, sourceApplication: String?, annotation: Any) -> Bool {
        return true
    }

    func application(_ application: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any]) -> Bool {
        return true
    }

    func handleIncomingNotification(userInfo: [AnyHashable : Any]) {
        if let aps = userInfo["aps"] as? [String: Any] {
            if let alert = aps["alert"] as? String {
                print("Notification received: \(alert)")
            }
        }
    }

    func checkForUnresolvedErrors(error: NSError) {
        if let errorCode = error.code {
            switch errorCode {
            case NSFileReadNoSuchFileError:
                print("File not found.")
            case NSFileWriteOutOfSpaceError:
                print("Out of space.")
            default:
                print("An error occurred: \(error.localizedDescription)")
            }
        }
    }

    func configurePushNotificationSettings() {
        let notificationCenter = UNUserNotificationCenter.current()
        notificationCenter.delegate = self
        let options: UNAuthorizationOptions = [.alert, .badge, .sound]
        notificationCenter.requestAuthorization(options: options) { granted, error in
            if granted {
                DispatchQueue.main.async {
                    UIApplication.shared.registerForRemoteNotifications()
                }
            }
        }
    }

    func fetchUserData(userID: String, completion: @escaping (User?) -> Void) {
        Firestore.firestore().collection("users").document(userID).getDocument { (document, error) in
            if let document = document, document.exists {
                let userData = document.data()
                let user = User(data: userData)
                completion(user)
            } else {
                completion(nil)
            }
        }
    }

    func sendUserNotification(title: String, body: String) {
        let content = UNMutableNotificationContent()
        content.title = title
        content.body = body
        content.sound = UNNotificationSound.default
        let request = UNNotificationRequest(identifier: "notificationID", content: content, trigger: nil)
        UNUserNotificationCenter.current().add(request)
    }

    func setupAnalytics() {
        Analytics.logEvent("app_launch", parameters: [
            "time": Date().description
        ])
    }
    
    func configureAnalyticsTracking() {
        Analytics.setUserProperty("User ID", forName: "user_id")
        Analytics.setUserID("user_12345")
    }
}

extension AppDelegate: UNUserNotificationCenterDelegate {
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.alert, .badge, .sound])
    }

    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        handleIncomingNotification(userInfo: response.notification.request.content.userInfo)
        completionHandler()
    }
}

// \(file) - Placeholder for your code.
