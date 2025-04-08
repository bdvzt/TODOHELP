//
//  TaskListStore.swift
//  TODOAPP
//
//  Created by Zayata Budaeva on 07.04.2025.
//

import Foundation
import SwiftUI

protocol TaskListModelStateProtocol {
    var state: TaskListState { get }
    func rowColor(for task: Task) -> Color?
}

protocol TaskListModelActionsProtocol: AnyObject {
    func applyIntent(_ intent: TaskListIntentType)
}

final class TaskListStore: ObservableObject, TaskListModelActionsProtocol, TaskListModelStateProtocol {
    @Published private(set) var state = TaskListState()
    private let taskService: TaskServiceProtocol

    init(taskService: TaskServiceProtocol = TaskService()) {
        self.taskService = taskService
    }

    func applyIntent(_ intent: TaskListIntentType) {
        switch intent {
        case .load:
            taskService.fetchTasks { [weak self] tasks in
                DispatchQueue.main.async {
                    self?.state.tasks = tasks
                    self?.sortTasks()
                }
            }

        case .sort(let option):
            updateSortOption(option)

        case .edit(let updatedTask):
            taskService.updateTask(updatedTask) { [weak self] in
                self?.applyIntent(.load)
            }

        case .create(let task):
            taskService.createTask(task) { [weak self] in
                self?.applyIntent(.load)
            }

        case .toggleStatus(let task):
            let newStatus: TaskStatus = {
                if task.status == .completed || task.status == .late {
                    return .active
                } else if let deadline = task.deadline, deadline < Date() {
                    return .late
                } else {
                    return .completed
                }
            }()
            let dto = TaskStatusUpdateDTO(id: task.id, status: newStatus.rawValue)
            taskService.updateStatus(task: dto) { [weak self] in
                self?.applyIntent(.load)
            }

        case .delete(let task):
            taskService.deleteTask(id: task.id) { [weak self] in
                self?.applyIntent(.load)
            }

        case .showError(let message):
            print("Error: \(message)")
        }
    }

    func rowColor(for task: Task) -> Color? {
        guard task.status == .active else { return nil }
        guard let deadline = task.deadline else { return nil }

        let now = Date()
        if deadline < now {
            return Color.red.opacity(0.2)
        } else if deadline.timeIntervalSince(now) < 3 * 24 * 60 * 60 {
            return Color.orange.opacity(0.2)
        }
        return nil
    }

    private func updateSortOption(_ option: SortOption) {
        state.sortOption = option
        sortTasks()
    }

    private func toggleTaskStatus(_ task: Task) {
        guard let index = state.tasks.firstIndex(where: { $0.id == task.id }) else { return }
        let current = state.tasks[index]
        let newStatus: TaskStatus = {
            if current.status == .completed || current.status == .late {
                return .active
            } else if let deadline = current.deadline, deadline < Date() {
                return .late
            } else {
                return .completed
            }
        }()
        state.tasks[index].status = newStatus
        state.tasks[index].updatedAt = Date()
    }

    private func deleteTask(_ task: Task) {
        state.tasks.removeAll { $0.id == task.id }
    }

    private func sortTasks() {
        switch state.sortOption {
        case .byDeadline:
            state.tasks.sort { ($0.deadline ?? .distantFuture) < ($1.deadline ?? .distantFuture) }
        case .byCreatedAt:
            state.tasks.sort { $0.createdAt < $1.createdAt }
        case .byPriority:
            state.tasks.sort { $0.priority.sortIndex > $1.priority.sortIndex }
        }
    }
}

