//
//  NetworkManager.swift
//  Health Journal
//
//  Created by Sadrac Tijerina on 9/12/20.
//  Copyright © 2020 M-A-I-D-S. All rights reserved.
//
import Foundation

struct NetworkManager {
    
    var userTasks: Array<Tasks>
    let taskURL = ProcessInfo.processInfo.environment["apiURL"]
    
    init(userID: String){
        /*
         I am assuming this is how we will get task in future
         let urlString = "\(userID)/\(tasks)"
         */
        
        let urlString = "http://localhost:3000/tasks/"
        
        userTasks = Array<Tasks>()
        
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
                    let decoder = JSONDecoder()
                    
                    do {
                        let decoderData = try decoder.decode(TaskData.self, from: safeData)
                        for object in decoderData.tasks {
                            userTasks.append(object)
                        }
                    } catch {
                        print("Error: \(error)")
                    }
                }
            }
            
            //Step 4 we start the task
            task.resume()
        }
        
    }
}
