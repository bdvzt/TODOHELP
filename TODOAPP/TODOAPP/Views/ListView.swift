import SwiftUI
import UniformTypeIdentifiers

struct ListView: View {
    @EnvironmentObject var listViewModel: ListViewModel
    
    var body: some View {
        VStack {
                    List {
                        ForEach(listViewModel.tasks) { task in
                            NavigationLink(destination: EditView(task: task)) {
                                ListRowView(task: task)
                            }
                        }
                        .onDelete(perform: deleteTask)
                    }
                    .listStyle(PlainListStyle())
                    .navigationTitle("TO-DO LIST")
                    .navigationBarItems(
                        leading: EditButton(),
                        trailing: NavigationLink("Add", destination: AddView())
                    )
            Button(action: {
                            listViewModel.getTasks()
                        }) {
                            Text("Refresh")
                                .foregroundColor(.white)
                                .font(.headline)
                                .frame(height: 60)
                                .frame(maxWidth: 120)
                                .background(Color.pink)
                                .cornerRadius(20)
                        }

                }
        
    }
    
    func deleteTask(at offsets: IndexSet) {
        let tasksToDelete = offsets.map { listViewModel.tasks[$0] }

        for task in tasksToDelete {
            let newTask = TaskModelDelete(id: task.id)
            listViewModel.deleteTask(task: newTask) { result in
                switch result {
                case .success:
                    print("Task deleted successfully!")
                case .failure(let error):
                    print("Error deleting task")
                }
            }
        }
    }
}

    
struct ListView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ListView()
                .environmentObject(ListViewModel())
        }
    }
}

