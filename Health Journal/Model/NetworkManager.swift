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
    
    func fetchTask(userID: String) {
        
        /*
         I am assuming this is how we will get task in future
         let urlString = "\(userID)/\(tasks)"
         performRequest(urlString: urlString)
         */
        
        performRequest(urlString: "http://localhost:5000/tasks/")
        
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
                    parseJSON(userData: safeData)
                }
            }
            
            //Step 4 we start the task
            task.resume()
        }
    }
    
    func parseJSON(userData: Data) {
        
    }
    
    //Also we can watch section 17 video 231. This video seemes most relatable/relevant
}
