//
//  TaskData.swift
//  Health Journal
//
//  Created by Sadrac Tijerina on 10/26/20.
//  Copyright © 2020 M-A-I-D-S. All rights reserved.
//

import Foundation

struct TaskData: Codable {
    let tasks: [Tasks]
}

struct Tasks : Codable {
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
