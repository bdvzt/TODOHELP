//
//  AddTaskView.swift
//  TODOAPP
//
//  Created by Zayata Budaeva on 27.03.2025.
//

import SwiftUI

struct AddTaskView: View {
    @StateObject private var container: MVIContainer<AddTaskIntent, AddTaskStore>

    @Environment(\.presentationMode) private var presentationMode

    private var intent: AddTaskIntent { container.intent }
    private var model: AddTaskStore { container.model }

    init(onSubmit: @escaping (Task) -> Void) {
        let store = AddTaskStore(onSubmit: onSubmit)
        let intent = AddTaskIntent(model: store)
        let container = MVIContainer(
            intent: intent,
            model: store,
            modelChangePublisher: store.objectWillChange
        )
        self._container = StateObject(wrappedValue: container)
    }

    var body: some View {
        Form {
            titleSection
            descriptionSection
            deadlineSection
            prioritySection
        }
        submitButton
        .navigationTitle("Add Task")
    }

    private var titleSection: some View {
        Section(header: Text("Title")) {
            TextField("Enter title", text: Binding(
                get: { model.state.title },
                set: { intent.send(.updateTitle($0)) }
            ))
        }
    }

    private var descriptionSection: some View {
        Section(header: Text("Description")) {
            TextField("Enter description", text: Binding(
                get: { model.state.description },
                set: { intent.send(.updateDescription($0)) }
            ))
        }
    }

    private var deadlineSection: some View {
        Section(header: Text("Deadline")) {
            DatePicker("", selection: Binding(
                get: { model.state.deadline ?? Date() },
                set: { intent.send(.updateDeadline($0)) }
            ), displayedComponents: .date)
        }
    }

    private var prioritySection: some View {
        Section(header: Text("Priority")) {
            Picker("Priority", selection: Binding(
                get: { model.state.priority },
                set: { intent.send(.updatePriority($0)) }
            )) {
                Text("Low").tag(TaskPriority.low)
                Text("Medium").tag(TaskPriority.medium)
                Text("High").tag(TaskPriority.high)
                Text("Critical").tag(TaskPriority.critical)
            }
            .pickerStyle(SegmentedPickerStyle())
        }
    }

    private var submitButton: some View {
        Button(action: {
            intent.send(.submit)
            presentationMode.wrappedValue.dismiss()
        }) {
            HStack {
                Spacer()
                Text("Create task")
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                Spacer()
            }
            .padding()
            .background(Color.pink)
            .cornerRadius(12)
            .shadow(radius: 4)
            .padding(.horizontal)
        }
    }
}
