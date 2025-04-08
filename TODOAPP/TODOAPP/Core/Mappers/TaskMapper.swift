//
//  TaskIntoDTO.swift
//  TODOAPP
//
//  Created by Zayata Budaeva on 27.03.2025.
//

import Foundation

extension Task {
    init?(dto: TaskDTO) {
        let dateFormatter = ISO8601DateFormatter()

        guard let status = TaskStatus(rawValue: dto.status),
              let priority = TaskPriority(rawValue: dto.priority),
              let createdAt = dateFormatter.date(from: dto.createdAt),
              let updatedAt = dateFormatter.date(from: dto.updatedAt)
        else {
            return nil
        }

        let deadline = dto.deadline.flatMap { dateFormatter.date(from: $0) }

        self.id = dto.id
        self.title = dto.title
        self.description = dto.description
        self.deadline = deadline
        self.status = status
        self.priority = priority
        self.createdAt = createdAt
        self.updatedAt = updatedAt
    }
}
