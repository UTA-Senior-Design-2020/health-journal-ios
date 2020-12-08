//
//  NetworkManager.swift
//  Health Journal
//
//  Created by Sadrac Tijerina on 9/12/20.
//  Copyright © 2020 M-A-I-D-S. All rights reserved.
//

import Foundation
import Alamofire


struct NetworkManager {
    private let userId: String
    let taskURL = ProcessInfo.processInfo.environment["apiURL"]
    
    public init(userId: String) {
        self.userId = userId
    }
    
    func fetchTasks(completion: @escaping (Tasks) -> Void){
        let urlString = "http://localhost:3000/tasks"
        AF.request(urlString).responseJSON{
            response in
            if let data = response.data{
                do{
                    //Issue is on the line right below. It is failing to do JSONDecoder. I didnt change a line from code on here so I am unsure,
                    //why there is an issue now.
                    let response = try JSONDecoder().decode(Tasks.self, from: data)
                    completion(response)
                }catch{
                    print("DEBUG: Server Returned Nothing")
                }
                
            }
            
        }
        
    }
}
