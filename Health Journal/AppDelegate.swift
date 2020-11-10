//
//  AppDelegate.swift
//  Health Journal
//
//  Created by Sadrac Tijerina on 8/26/20.
//  Copyright © 2020 M-A-I-D-S. All rights reserved.
//

import UIKit
import CareKit
import Contacts

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {


    // Manages synchronization of a CoreData store
    lazy var synchronizedStoreManager: OCKSynchronizedStoreManager = {
        
        //OCKStore is basically just a on-device database, here we are creating it
        //We can use any other database as well as long as it works with OCKStore protocol
        let store = OCKStore(name: "SampleAppStore1")
        
        store.populateSampleData()
        
        //OCKSynchronizedStoreManager is what makes it possible to use another database
        let manager = OCKSynchronizedStoreManager(wrapping: store)
        return manager
    }()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        return true
    }

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }
    
}




private extension OCKStore {

    // Add tasks and contacts into the store in this function
    func populateSampleData() {
        
        let networkManager = NetworkManager()
        
        networkManager.fetchTask(userID: "hello")
        
        let currentDate = Calendar.current.startOfDay(for: Date())
        let afternoonAtSevenMedication = Calendar.current.date(byAdding: .hour, value: 19, to: currentDate)!
        let beforeBreakfast = Calendar.current.date(byAdding: .hour, value: 8, to:currentDate)!
        
        let schedule = OCKSchedule(composing: [OCKScheduleElement(start: afternoonAtSevenMedication, end: nil, interval: DateComponents(day: 1))])
        
        var medication = OCKTask(id: "medication", title: "Take Levetiracetam Medicine", carePlanID: nil, schedule: schedule)
        
        medication.instructions = "Take 2500mg of levetiracetam everyday at 7pm"
        
        
        //These two errors are causing contradictions
        
//        addTask(medication) { result in
//            switch result {
//            case .failure(let error): print("Add Error: \(error)")
//            case .success: (print("Sucess task added"))
//            }
//
//        }
        
//        updateTask(medication) { result in
//            switch result {
//            case .failure(let error): print("Update Error: \(error)")
//            case .success: (print("Success task updated"))
//            }
//        }
        
        
        let seizureSchedule = OCKSchedule(composing: [OCKScheduleElement(start: beforeBreakfast, end: nil, interval: DateComponents(day:1), text: "Anytime thrhoughout the day", targetValues: [], duration: .allDay)])
        var seizureLog = OCKTask(id: "seizureLog", title: "Track your seizures", carePlanID: nil, schedule: seizureSchedule)
        seizureLog.impactsAdherence = false
        seizureLog.instructions = "Tap the button below anytime you experience a seizure"
        
        
        addTasks([medication, seizureLog], callbackQueue: .main, completion: nil)
                
    }
}



