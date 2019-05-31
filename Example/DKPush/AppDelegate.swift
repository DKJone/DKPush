//
//  AppDelegate.swift
//  DKPush
//
//  Created by DKJone on 05/30/2019.
//  Copyright (c) 2019 DKJone. All rights reserved.
//

import UIKit
import DKPush
import UserNotifications
@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {

            let entity = JPUSHRegisterEntity()
            entity.types = Int(JPAuthorizationOptions.alert.rawValue | JPAuthorizationOptions.badge.rawValue | JPAuthorizationOptions.sound.rawValue)
        JPUSHService.register(forRemoteNotificationConfig: entity, delegate: self)


        JPUSHService.setup(withOption: launchOptions, appKey: "ce0ff975805dc9e282b7376c", channel: "Development", apsForProduction: false)

            JPUSHService.registrationIDCompletionHandler { _, registrationID in
                if let registrationID = registrationID {
                    UserDefaults.standard.set(registrationID, forKey: "registrationID")
                }
            }


        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        print("++++++----" + (String(data: deviceToken, encoding: .utf8) ?? ""))
        JPUSHService.registerDeviceToken(deviceToken)
    }

}

extension AppDelegate:JPUSHRegisterDelegate{
    func jpushNotificationCenter(_ center: UNUserNotificationCenter!, didReceive response: UNNotificationResponse!, withCompletionHandler completionHandler: (() -> Void)!) {
        let userInfo = response.notification.request.content.userInfo
        if response.notification.request.trigger?.isKind(of: UNPushNotificationTrigger.self) ?? false {
            JPUSHService.handleRemoteNotification(userInfo)
            handleRemoteNotification(userInfo)

        }

        if let extra = userInfo["application"] as? String {
            if extra == "mall" {
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                }
            }
        }
        completionHandler()
    }

    func jpushNotificationCenter(_ center: UNUserNotificationCenter!, openSettingsFor notification: UNNotification?) {

    }

    func jpushNotificationCenter(_ center: UNUserNotificationCenter!, willPresent notification: UNNotification!, withCompletionHandler completionHandler: ((Int) -> Void)!) {
        let userInfo = notification.request.content.userInfo
        if notification.request.trigger?.isKind(of: JPushNotificationTrigger.self) ?? false {
            JPUSHService.handleRemoteNotification(userInfo)
            handleRemoteNotification(userInfo)
        }

        // 需要执行这个方法，选择是否提醒用户，有Badge、Sound、Alert三种类型可以选择设置
        completionHandler(Int(UNNotificationPresentationOptions.alert.rawValue))
    }



    /// 推送处理
    ///
    /// - Parameter userInfo: 推送的附加信息
    func handleRemoteNotification(_ userInfo: [AnyHashable: Any]) {
        JPUSHService.setBadge(0)
        UIApplication.shared.applicationIconBadgeNumber = 0
    }

}

