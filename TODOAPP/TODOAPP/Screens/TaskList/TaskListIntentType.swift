//
//  TaskListIntentType.swift
//  TODOAPP
//
//  Created by Zayata Budaeva on 08.04.2025.
//

enum TaskListIntentType {
    case load
    case delete(Task)
    case toggleStatus(Task)
    case sort(SortOption)
    case edit(task: Task)
    case create(task: Task)
    case showError(String)
}
