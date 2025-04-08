//
//  TaskListView.swift
//  TODOAPP
//
//  Created by Zayata Budaeva on 27.03.2025.
//

import SwiftUI

struct TaskListView: View {
    @StateObject private var container: MVIContainer<TaskListIntent, TaskListStore>

    private var intent: TaskListIntent { container.intent }
    private var model: TaskListStore { container.model }

    init() {
        let model = TaskListStore()
        let intent = TaskListIntent(model: model)
        let container = MVIContainer(
            intent: intent,
            model: model,
            modelChangePublisher: model.objectWillChange
        )
        self._container = StateObject(wrappedValue: container)
    }

    var body: some View {
        NavigationView {
            ZStack(alignment: .bottomTrailing) {
                VStack {
                    sortPicker
                    taskList
                }

                addTaskButton
            }
            .navigationTitle("TO-DO LIST")
            .navigationBarItems(leading: EditButton())
        }
        .onAppear {
            intent.send(.load)
        }
    }

    private var sortPicker: some View {
        Picker("Sort by", selection: Binding(
            get: { model.state.sortOption },
            set: { intent.send(.sort($0)) }
        )) {
            Text("By deadline").tag(SortOption.byDeadline)
            Text("By creation").tag(SortOption.byCreatedAt)
            Text("By priority").tag(SortOption.byPriority)
        }
        .pickerStyle(SegmentedPickerStyle())
        .padding(.horizontal)
    }

    private var taskList: some View {
        List {
            ForEach(model.state.tasks) { task in
                NavigationLink(
                    destination: TaskEditView(task: task, onSubmit: { updatedState in
                        intent.send(.edit(task: updatedState.toTask(from: task)))
                    })
                ) {
                    TaskListRow(task: task, toggleStatus: {
                        intent.send(.toggleStatus(task))
                    })
                }
                .listRowBackground(model.rowColor(for: task))
            }
            .onDelete { indexSet in
                indexSet.map { model.state.tasks[$0] }
                    .forEach { intent.send(.delete($0)) }
            }
        }
        .listStyle(PlainListStyle())
    }

    private var addTaskButton: some View {
        NavigationLink(destination: AddTaskView(onSubmit: { newTask in
            intent.send(.create(task: newTask))
        })) {
            Image(systemName: "plus")
                .font(.system(size: 24))
                .padding()
                .background(Color.pink)
                .foregroundColor(.white)
                .clipShape(Circle())
                .shadow(radius: 4)
                .padding()
        }
    }
}

#Preview {
    TaskListView()
}
