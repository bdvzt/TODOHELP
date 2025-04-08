//
//  TaskFormIntentType.swift
//  TODOAPP
//
//  Created by Zayata Budaeva on 08.04.2025.
//

import Foundation

enum TaskFormIntentType {
    case updateTitle(String)
    case updateDescription(String)
    case updateDeadline(Date?)
    case updatePriority(TaskPriority)
    case submit
}
