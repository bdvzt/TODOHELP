//
//  TaskListRowView.swift
//  TODOAPP
//
//  Created by Zayata Budaeva on 27.03.2025.
//

import SwiftUI

struct TaskListRow: View {
    let task: Task
    let toggleStatus: () -> Void

    var body: some View {
        HStack {
            Image(systemName: task.status == .completed || task.status == .late ? "checkmark.circle.fill" : "circle")
                .foregroundColor(task.status == .completed ? .green : .gray)
                .onTapGesture {
                    toggleStatus()
                }

            VStack(alignment: .leading) {
                Text(task.title)
                    .font(.headline)
                    .strikethrough(task.status == .completed || task.status == .late)
                if let deadline = task.deadline {
                    Text("Deadline: \(deadline.formatted(date: .abbreviated, time: .omitted))")
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
            }
            Spacer()

            Text(task.priority.rawValue)
                .font(.caption)
                .padding(6)
                .background(Color.gray.opacity(0.2))
                .cornerRadius(6)
        }
        .padding(.vertical, 6)
    }
}
