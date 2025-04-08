//
//  Task.swift
//  TODOAPP
//
//  Created by Zayata Budaeva on 27.03.2025.
//

import Foundation

struct Task: Identifiable {
    let id: UUID
    var title: String
    var description: String?
    var deadline: Date?
    var status: TaskStatus
    var priority: TaskPriority
    let createdAt: Date
    var updatedAt: Date?
}
