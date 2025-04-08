//
//  TaskListService.swift
//  TODOAPP
//
//  Created by Zayata Budaeva on 27.03.2025.
//

import Foundation

protocol TaskServiceProtocol {
    func fetchTasks(completion: @escaping ([Task]) -> Void)
    func deleteTask(id: UUID, completion: @escaping () -> Void)
    func updateStatus(task: TaskStatusUpdateDTO, completion: @escaping () -> Void)
    func createTask(_ task: Task, completion: @escaping () -> Void)
    func updateTask(_ task: Task, completion: @escaping () -> Void)
}

class TaskService: TaskServiceProtocol {
    private var mockTasks: [Task] = [
        Task(
            id: UUID(),
            title: "Тудушка для тестирования",
            description: "18:25",
            deadline: Calendar.current.date(byAdding: .day, value: 1, to: Date()),
            status: .active,
            priority: .critical,
            createdAt: Date(),
            updatedAt: nil
        ),
        Task(
            id: UUID(),
            title: "Джава",
            description: "Доделать юзер-сервис",
            deadline: Calendar.current.date(byAdding: .day, value: 5, to: Date()),
            status: .active,
            priority: .high,
            createdAt: Date(),
            updatedAt: nil
        ),
        Task(
            id: UUID(),
            title: "Джава",
            description: "Начать сервис автомобилей",
            deadline: Calendar.current.date(byAdding: .day, value: 10, to: Date()),
            status: .active,
            priority: .high,
            createdAt: Date(),
            updatedAt: nil
        )
    ]

    func fetchTasks(completion: @escaping ([Task]) -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            completion(self.mockTasks)
        }
    }

    func deleteTask(id: UUID, completion: @escaping () -> Void) {
        self.mockTasks.removeAll { $0.id == id }
        DispatchQueue.main.async {
            completion()
        }
    }

    func updateStatus(task: TaskStatusUpdateDTO, completion: @escaping () -> Void) {
        if let index = mockTasks.firstIndex(where: { $0.id == task.id }) {
            var old = mockTasks[index]
            if let newStatus = TaskStatus(rawValue: task.status) {
                old = Task(
                    id: old.id,
                    title: old.title,
                    description: old.description,
                    deadline: old.deadline,
                    status: newStatus,
                    priority: old.priority,
                    createdAt: old.createdAt,
                    updatedAt: Date()
                )
                mockTasks[index] = old
            }
        }
        DispatchQueue.main.async {
            completion()
        }
    }

    func createTask(_ task: Task, completion: @escaping () -> Void) {
        mockTasks.append(task)
        DispatchQueue.main.async {
            completion()
        }
    }

    func updateTask(_ task: Task, completion: @escaping () -> Void) {
        if let index = mockTasks.firstIndex(where: { $0.id == task.id }) {
            mockTasks[index] = task
        }
        DispatchQueue.main.async {
            completion()
        }
    }
}
