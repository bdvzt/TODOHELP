//
//  TaskEditStore.swift
//  TODOAPP
//
//  Created by Zayata Budaeva on 08.04.2025.
//

import Foundation

protocol TaskEditModelActionsProtocol: AnyObject {
    func applyIntent(_ intent: TaskFormIntentType)
}

protocol TaskEditModelStateProtocol {
    var state: TaskFormState { get }
}

final class TaskEditStore: ObservableObject, TaskEditModelActionsProtocol, TaskEditModelStateProtocol {
    @Published private(set) var state: TaskFormState

    private let taskService: TaskServiceProtocol
    private let onSubmit: (TaskFormState) -> Void
    private let originalTask: Task

    init(
        initialTask: Task,
        taskService: TaskServiceProtocol = TaskService(),
        onSubmit: @escaping (TaskFormState) -> Void
    ) {
        self.originalTask = initialTask
        self.taskService = taskService
        self.onSubmit = onSubmit
        self.state = TaskFormState(
            title: initialTask.title,
            description: initialTask.description ?? "",
            deadline: initialTask.deadline,
            priority: initialTask.priority
        )
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
            onSubmit(state)
        }
    }
}
