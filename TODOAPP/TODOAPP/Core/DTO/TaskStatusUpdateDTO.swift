//
//  TaskStatusUpdateDTO.swift
//  TODOAPP
//
//  Created by Zayata Budaeva on 27.03.2025.
//

import Foundation

struct TaskStatusUpdateDTO: Encodable {
    let id: UUID
    let status: String
}
