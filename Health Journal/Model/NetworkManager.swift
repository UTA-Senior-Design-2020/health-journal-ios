//
//  NetworkManager.swift
//  Health Journal
//
//  Created by Sadrac Tijerina on 9/12/20.
//  Copyright © 2020 M-A-I-D-S. All rights reserved.
//

import Foundation

struct NetworkManager {
    
    let taskURL = ProcessInfo.processInfo.environment["apiURL"]
    
    var userTasks: [Tasks]
        
    func fetchTask(userID: String) {
        
        /*
         I am assuming this is how we will get task in future
         let urlString = "\(userID)/\(tasks)"
         performRequest(urlString: urlString)
         */
        performRequest(urlString: "http://localhost:3000/tasks/")
        
    }
    
    func performRequest(urlString: String){
        //creating a URL object
        if let url = URL(string: urlString) {
            
            //we are creating a URLSession. This does the networking
            let session = URLSession(configuration: .default)
            
            //Step 3 we give a URLSession a task
            let task = session.dataTask(with: url) { (data, response, error) in
                if error != nil {
                    print(error!)
                    return
                }
                
                if let safeData = data {
                    parseJSON(taskData: safeData)
                }
            }
            
            //Step 4 we start the task
            task.resume()
        }
    }
    
    func parseJSON(taskData: Data) {
                
        let decoder = JSONDecoder()

        do {
            let decoderData = try decoder.decode(TaskData.self, from: taskData)
            userTasks = decoderData.tasks
        } catch {
            print("Error: \(error)")
        }

    }

    //So I have to find a way to pass the data from networkmanager to appdelegate file.
    
}
