//
//  TaskEditDTO.swift
//  TODOAPP
//
//  Created by Zayata Budaeva on 27.03.2025.
//

import Foundation

struct TaskEditDTO: Encodable {
    let id: UUID
    let title: String
    let description: String?
    let deadline: String?
    let priority: String?
}
