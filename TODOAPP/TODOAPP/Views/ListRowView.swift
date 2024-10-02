import SwiftUI

struct ListRowView: View {
    let task: TaskModel
    
    var body: some View {
        HStack{
            Image(systemName: task.isDone ? "checkmark.circle" : "circle")
                .foregroundColor(task.isDone ? .green : .red)
            Text(task.description)
            Spacer()
        }
        .font(.title2)
        .padding(.vertical, 8 )
    }
}

struct ListRowView_Previews: PreviewProvider {
    
    static var task1 = TaskModel(description: "d", isDone: false)
    static var task2 = TaskModel(description: "d1", isDone: true)
    
    static var previews: some View {
        Group{
            ListRowView(task: task1)
            ListRowView(task: task2 )
        }
        .previewLayout(.sizeThatFits)
    }
}


