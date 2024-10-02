import SwiftUI

struct ListRowView: View {
    let task: TaskModel
    
    var body: some View {
        HStack{
            Image(systemName: task.status ? "checkmark.circle" : "circle")
                .foregroundColor(task.status ? .green : .red)
            Text(task.description)
            Spacer()
        }
        .font(.title2)
        .padding(.vertical, 8 )
    }
}

struct ListRowView_Previews: PreviewProvider {
    static var task1 = TaskModel(id: UUID(), description: "1", status: false)
    static var task2 = TaskModel(id: UUID(), description: "2", status: true)

    static var previews: some View {
        Group {
            ListRowView(task: task1)
            ListRowView(task: task2)
        }
        .previewLayout(.sizeThatFits)
    }
}

