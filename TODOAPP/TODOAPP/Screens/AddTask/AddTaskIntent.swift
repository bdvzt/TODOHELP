//
//  AddTaskIntent.swift
//  TODOAPP
//
//  Created by Zayata Budaeva on 08.04.2025.
//

final class AddTaskIntent {
    private weak var model: AddTaskModelActionsProtocol?

    init(model: AddTaskModelActionsProtocol) {
        self.model = model
    }

    func send(_ intent: TaskFormIntentType) {
        model?.applyIntent(intent)
    }
}
