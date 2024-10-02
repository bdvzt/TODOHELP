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
                            .onTapGesture {
                                withAnimation(.linear) {
                                    listViewModel.updateItem(task: task)
                                }
                            }
                    }
                }
                .onDelete(perform: listViewModel.delete)
                .onMove(perform: listViewModel.move)
            }
            .listStyle(PlainListStyle())
            .navigationTitle("TO-DO LIST")
            .navigationBarItems(
                leading: EditButton(),
                trailing: NavigationLink("Add", destination: AddView())
            )
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

