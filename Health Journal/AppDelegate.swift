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
        let store = OCKStore(name: "SampleAppStore4")
        
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
        //var taskObjects = [OCKTask]()
        let networkManager = NetworkManager(userId: "1")
        networkManager.fetchTasks(){
            response in
            
            for task in response.data{
                let currentDate = Calendar.current.startOfDay(for: Date())
                let afternoonAtSevenMedication = Calendar.current.date(byAdding: .hour, value: 19, to: currentDate)!
                let schedule = OCKSchedule(composing: [OCKScheduleElement(start: afternoonAtSevenMedication, end: nil, interval: DateComponents(day: task.Frequency))])
                
                switch task.TaskType {
                case 1:
                    print("In case 1")
                    var taskObj = OCKTask(id: String(task.TaskId), title: task.Title, carePlanID: nil, schedule: schedule)
                    if task.ImpactsAdherence == 0 { taskObj.impactsAdherence = false }
                    //taskObjects.append(taskObj)
                    self.addTask(taskObj, callbackQueue: .main, completion: nil)
                case 2:
                    print("In case 2")
                    var taskObj = OCKTask(id: String(task.TaskId), title: task.Title, carePlanID: nil, schedule: schedule)
                    taskObj.instructions = task.Instruction
                    if task.ImpactsAdherence == 0 { taskObj.impactsAdherence = false }
                    //taskObjects.append(taskObj)
                    self.addTask(taskObj, callbackQueue: .main, completion: nil)
                case 3:
                    print("In case 3")
                    var taskObj = OCKTask(id: String(task.TaskId), title: task.Title, carePlanID: nil, schedule: schedule)
                    taskObj.instructions = task.Instruction
                    taskObj.impactsAdherence = false
                    //taskObjects.append(taskObj)
                    self.addTask(taskObj, callbackQueue: .main, completion: nil)
                case 4:
                    print("This is for a checklist task, not sure what the task object info it needs")
                case 5:
                    print("This is for gridlist task, not sure as well what info it needs")
                default:
                    print("In default which is case 1")
                    var taskObj = OCKTask(id: String(task.TaskId), title: task.Title, carePlanID: nil, schedule: schedule)
                    if task.ImpactsAdherence == 0 { taskObj.impactsAdherence = false }
                    //taskObjects.append(taskObj)
                    self.addTask(taskObj, callbackQueue: .main, completion: nil)
                }
                
            }
            
        }
        
    }
}


