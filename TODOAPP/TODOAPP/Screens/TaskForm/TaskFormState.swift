//
//  AddTaskState.swift
//  TODOAPP
//
//  Created by Zayata Budaeva on 08.04.2025.
//

import Foundation

struct TaskFormState {
    var title: String = ""
    var description: String = ""
    var deadline: Date? = nil
    var priority: TaskPriority = .medium
}

extension TaskFormState {
    func toTask(from oldTask: Task) -> Task {
        return Task(
            id: oldTask.id,
            title: self.title,
            description: self.description,
            deadline: self.deadline,
            status: oldTask.status,
            priority: self.priority,
            createdAt: oldTask.createdAt,
            updatedAt: Date()
        )
    }
}
