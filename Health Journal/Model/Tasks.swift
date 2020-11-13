//
//  Tasks.swift
//  Health Journal
//
//  Created by Ivan Jaimes on 11/13/20.
//  Copyright © 2020 M-A-I-D-S. All rights reserved.
//

import Foundation

class Tasks: Codable {
    var data: [Task]
}
class Task: Codable{
    let TaskId: Int
    let Title: String?
    let StartDate: String
    let EndDate: String?
    let Frequency: Int
    let Instruction: String?
    let ImpactsAdherence: Int
    let TaskType: Int
    let PlotType: Int
    let PatientId: Int
}
