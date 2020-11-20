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
        let urlString = "http://localhost:5000/patients/\(self.userId)/tasks"
        AF.request(urlString).responseJSON{
            response in
            if let data = response.data{
                do{
                    let response = try JSONDecoder().decode(Tasks.self, from: data)
                    completion(response)
                }catch{
                    print("Server Returned Nothing")
                }
                
            }
            
        }
        
    }
}
