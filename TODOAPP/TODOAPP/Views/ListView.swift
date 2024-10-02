import SwiftUI
import UniformTypeIdentifiers

struct ListView: View {
    @EnvironmentObject var listViewModel: ListViewModel
    
    var body: some View {
//        VStack {
//            List {
//                ForEach(listViewModel.tasks) { task in
//                    NavigationLink(destination: EditView(task: task)) {
//                        ListRowView(task: task)
//                            .onTapGesture {
//                                withAnimation(.linear) {
//                                    let newTask = TaskModelUpdate(id: task.id, status: task.status)
//                                    listViewModel.updateTask(task: newTask){ result in
//                                        // Handle the result of the deletion
//                                        switch result {
//                                        case .success:
//                                            // Deletion successful
//                                            print("Task deleted successfully!")
//                                        case .failure(let error):
//                                            // Deletion failed, handle the error
//                                            print("Error deleting task: (error.localizedDescription)")
//                                        }
//                                    }
//                                }
//                            }
//                    }
//                }
//                .onDelete(perform: deleteTask)
//                //                .onMove(perform: listViewModel.move)
//            }
//            .listStyle(PlainListStyle())
//            .navigationTitle("TO-DO LIST")
//            .navigationBarItems(
//                leading: EditButton(),
//                trailing: NavigationLink("Add", destination: AddView())
//            )
//        }
        VStack {
                    List {
                        ForEach(listViewModel.tasks) { task in
                            NavigationLink(destination: EditView(task: task)) {
                                ListRowView(task: task)
                            }
                        }
                        .onDelete(perform: deleteTask)
                        //                .onMove(perform: listViewModel.move)
                    }
                    .listStyle(PlainListStyle())
                    .navigationTitle("TO-DO LIST")
                    .navigationBarItems(
                        leading: EditButton(),
                        trailing: NavigationLink("Add", destination: AddView())
                    )
                }
        
    }
    
    func deleteTask(at offsets: IndexSet) {
        // Get the tasks to be deleted from the index set
        let tasksToDelete = offsets.map { listViewModel.tasks[$0] }

        // Delete tasks from the listViewModel
        for task in tasksToDelete {
            let newTask = TaskModelDelete(id: task.id)
            listViewModel.deleteTask(task: newTask) { result in
                // Handle the result of the deletion
                switch result {
                case .success:
                    // Deletion successful
                    print("Task deleted successfully!")
                case .failure(let error):
                    // Deletion failed, handle the error
                    print("Error deleting task: (error.localizedDescription)")
                }
            }
        }
    }
    
//    func updateTask(at offsets: IndexSet) {
//        // Get the tasks to be deleted from the index set
//        let tasksToDelete = offsets.map { listViewModel.tasks[$0] }
//
//        // Delete tasks from the listViewModel
//        for task in tasksToDelete {
//            let newTask = TaskModelUpdate(status: task.status)
//            listViewModel.updateTask(task: newTask) { result in
//                // Handle the result of the deletion
//                switch result {
//                case .success:
//                    // Deletion successful
//                    print("Task deleted successfully!")
//                case .failure(let error):
//                    // Deletion failed, handle the error
//                    print("Error deleting task: (error.localizedDescription)")
//                }
//            }
//        }
//    }
}

    
struct ListView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ListView()
                .environmentObject(ListViewModel())
        }
    }
}

