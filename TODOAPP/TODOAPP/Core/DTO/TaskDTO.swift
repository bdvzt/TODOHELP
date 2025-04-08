//
//  TaskDTO.swift
//  TODOAPP
//
//  Created by Zayata Budaeva on 27.03.2025.
//

import Foundation

struct TaskDTO: Codable {
    let id: UUID
    let title: String
    let description: String?
    let deadline: String?
    let status: String
    let priority: String
    let createdAt: String
    let updatedAt: String
}
