//
//  AddTaskStore.swift
//  TODOAPP
//
//  Created by Zayata Budaeva on 08.04.2025.
//

import Foundation

protocol AddTaskModelStateProtocol {
    var state: TaskFormState { get }
}

protocol AddTaskModelActionsProtocol: AnyObject {
    func applyIntent(_ intent: TaskFormIntentType)
}

final class AddTaskStore: ObservableObject, AddTaskModelActionsProtocol, AddTaskModelStateProtocol {
    @Published private(set) var state = TaskFormState()

    private let taskService: TaskServiceProtocol
    private let onSubmit: (Task) -> Void

    init(taskService: TaskServiceProtocol = TaskService(),
         onSubmit: @escaping (Task) -> Void) {
        self.taskService = taskService
        self.onSubmit = onSubmit
    }

    func applyIntent(_ intent: TaskFormIntentType) {
        switch intent {
        case .updateTitle(let rawTitle):
            let parsed = parseTitle(rawTitle)
            state.title = parsed.title
            state.priority = parsed.priority
            if let parsedDeadline = parsed.deadline {
                state.deadline = parsedDeadline
            }

        case .updateDescription(let description):
            state.description = description

        case .updateDeadline(let deadline):
            state.deadline = deadline

        case .updatePriority(let priority):
            state.priority = priority

        case .submit:
            let now = Date()
            let task = Task(
                id: UUID(),
                title: state.title,
                description: state.description,
                deadline: state.deadline,
                status: .active,
                priority: state.priority,
                createdAt: now,
                updatedAt: now
            )
            onSubmit(task)
        }
    }
}
