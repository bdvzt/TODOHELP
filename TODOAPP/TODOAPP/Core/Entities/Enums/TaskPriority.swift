//
//  TaskPriority.swift
//  TODOAPP
//
//  Created by Zayata Budaeva on 27.03.2025.
//

enum TaskPriority: String {
    case low = "Low"
    case medium = "Medium"
    case high = "High"
    case critical = "Critical"
}

extension TaskPriority {
    var sortIndex: Int {
        switch self {
        case .critical: return 4
        case .high: return 3
        case .medium: return 2
        case .low: return 1
        }
    }
}
