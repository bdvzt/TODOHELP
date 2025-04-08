//
//  TaskListIntent.swift
//  TODOAPP
//
//  Created by Zayata Budaeva on 07.04.2025.
//

import SwiftUI

final class TaskListIntent {
    private weak var model: TaskListModelActionsProtocol?

    init(model: TaskListModelActionsProtocol) {
        self.model = model
    }

    func send(_ intent: TaskListIntentType) {
        model?.applyIntent(intent)
    }
}
