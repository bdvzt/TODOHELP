//
//  TaskEditIntent.swift
//  TODOAPP
//
//  Created by Zayata Budaeva on 08.04.2025.
//

final class TaskEditIntent {
    private weak var model: TaskEditModelActionsProtocol?

    init(model: TaskEditModelActionsProtocol) {
        self.model = model
    }

    func send(_ intent: TaskFormIntentType) {
        model?.applyIntent(intent)
    }
}
