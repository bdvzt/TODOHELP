//
//  TaskCreateDTO.swift
//  TODOAPP
//
//  Created by Zayata Budaeva on 27.03.2025.
//

import Foundation

struct TaskCreateDTO: Encodable {
    let title: String
    let description: String?
    let deadline: String?
    let priority: String?
}
