//
//  ContentView.swift
//  Health Journal
//
//  Created by Sadrac Tijerina on 8/26/20.
//  Copyright © 2020 M-A-I-D-S. All rights reserved.
//

import Foundation
import UIKit
import CareKit
import Firebase

//OCKDailyViewController is a view controller that displays a calender in the header, and a page view controller in the body
class ContentView: OCKDailyPageViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //logUserOut()
        checkIfUserIsLoggedIn()
        
        //This is creating the care team button from the top right and calls the presentContactdListViewController when clicked
        navigationItem.rightBarButtonItem =
            UIBarButtonItem(title: "Log out", style: .plain, target: self,
                            action: #selector(logUserOut))
    }

    @objc func logUserOut() {
        do {
            try Auth.auth().signOut()
            let controller = LoginController()
            let nav = UINavigationController(rootViewController: controller)
            nav.modalPresentationStyle = .fullScreen
            self.present(nav, animated: true, completion: nil)
        } catch {
            print("DEBUG: Failed to sign out...")
        }
    }
    
    func checkIfUserIsLoggedIn() {
        if Auth.auth().currentUser == nil {
            DispatchQueue.main.async {
                let controller = LoginController()
                let nav = UINavigationController(rootViewController: controller)
                nav.modalPresentationStyle = .fullScreen
                self.present(nav, animated: true, completion: nil)
            }
        }
    }
    
    //This is how we are displaying contacts
    @objc private func presentContactsListViewController() {
        //This is creating the viewController which displays the contacts, we just need to pass the storeManager
        //Store manager gets intialized and created on an OCKDailyPageViewController
        let viewController = OCKContactsListViewController(storeManager: storeManager)
        
        //This is once they are in the contact page. The title will be Care team and to exit there will be a done button to the right
        viewController.title = "Health Team"
        
        // modalInPresentation is set on the view controller when you wish to force the presentation hosting the view controller into modal behavior. When this is active, the presentation will prevent interactive dismiss and ignore events outside of the presented view controller's bounds until this is set to NO.
        
        viewController.isModalInPresentation = true //still dont know what this does comment above I found in their definition
        viewController.navigationItem.rightBarButtonItem =
            UIBarButtonItem(title: "Done", style: .plain, target: self,
                            action: #selector(dismissContactsListViewController))

         
        let navigationController = UINavigationController(rootViewController: viewController) // this is what makes the view look stacked on top of one another
        present(navigationController, animated: true, completion: nil) //Now it shows the view, completion is what we plan to execute after the presentation finishes
    }

    @objc private func dismissContactsListViewController() {
        dismiss(animated: true, completion: nil)
    }

    // This will be called each time the selected date changes.
    // Use this as an opportunity to rebuild the content shown to the user.
    //When the CareViewController class is called/used this function gets used, listViewController parameter is what we populate with content, dailyPageViewController is what the app provides as content, and date is a date that determines the content to insert into the list view cnotroller
    
    override func dailyPageViewController(_ dailyPageViewController: OCKDailyPageViewController,
                                          prepare listViewController: OCKListViewController, for date: Date) {
        
    
        let identifiers = ["1", "2", "3"]
        var query = OCKTaskQuery(for: date) //A query that limits which task your fetch returns
        query.ids = identifiers //This looks for tasks that have the id listed in the variable identifiers. The tasks were created in AppDelegate.swift
        query.excludesTasksWithNoEvents = true //False is default

        storeManager.store.fetchAnyTasks(query: query, callbackQueue: .main) { result in //fetchAnyTasks retrieves a set of stack from the store
            switch result {
            case .failure(let error): print("Error: \(error)")
            case .success(let tasks):


                // Create a card for the levetiracetam task if there are events for it on this day.
                if let levetiracetamTask = tasks.first(where: { $0.id == "1" }) {
                    let levetiracetamCard = OCKInstructionsTaskViewController(task: levetiracetamTask, eventQuery: .init(for: date),
                                                                        storeManager: self.storeManager)
                    
                    listViewController.appendViewController(levetiracetamCard, animated: false)
                }
                
                if let depekeneTask = tasks.first(where: {$0.id == "2"}) {
                    
                    let depekeneCard = OCKInstructionsTaskViewController(task: depekeneTask, eventQuery: .init(for: date), storeManager: self.storeManager)
                    
                    listViewController.appendViewController(depekeneCard, animated: false)
                }

                if let seizureLogTask = tasks.first(where: {$0.id == "3"}) {
                    
                    let seizureLogCard = OCKButtonLogTaskViewController(task: seizureLogTask, eventQuery: .init(for: date), storeManager: self.storeManager)
                    
                    listViewController.appendViewController(seizureLogCard, animated: false)
                }
            }
        }
    }
}
