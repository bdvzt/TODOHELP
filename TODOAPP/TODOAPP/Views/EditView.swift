import SwiftUI

struct EditView: View {
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var listViewModel: ListViewModel
    var task: TaskModel
    
    @State private var textFieldText: String = ""
    
    @State var alertText: String = "Your task must have at least 1 symbol"
    @State var isAlert: Bool = false
    
    let bg = Color(UIColor(red: 0.9, green: 0.9, blue: 0.9, alpha: 1.0))
    
    var body: some View {
        ScrollView{
            VStack {
                TextField("Edit", text: $textFieldText)
                    .padding(.horizontal)
                    .frame(height: 80)
                    .background(bg)
                    .cornerRadius(20)
                Button(action: editTask, label:{
                    Text ("Save")
                        .foregroundColor(.white)
                        .font(.headline)
                        .frame(height: 60)
                        .frame(maxWidth: .infinity)
                        .background(Color.pink)
                        .cornerRadius(20)
                })
            }
            .padding(14)
        }
        .navigationTitle("Edit the task")
        .onAppear {
            textFieldText = task.description
        }
        .alert(isPresented: $isAlert, content: getAlert)
    }
    
//    func editTask(){
//        if check(){
//            listViewModel.editDescription(task: task, description: textFieldText)
//            presentationMode.wrappedValue.dismiss()
//        }
//        else{
//            
//        }
//    }
    
    func editTask() {
            if textFieldText.isEmpty {
                isAlert = true
                return
            }
            
        let newTask = TaskModelEdit(id: task.id, description: textFieldText)
        listViewModel.editTask(task: newTask)
            
        presentationMode.wrappedValue.dismiss()
        }
    
    func check()->Bool{
        if textFieldText.count < 1 {
            isAlert.toggle()
            return false
        }
        return true
    }
    
    func getAlert()->Alert{
        return Alert(title: Text(alertText))
    }
}

struct EditView_Previews: PreviewProvider {
    static var previews: some View {
        let testTask = TaskModel(id: UUID(), description: "d", status: false)
            

//        let testTask = TaskModel(Id: "1", Description: "Test Task", Status: false)
        let testViewModel = ListViewModel()
        testViewModel.tasks = [testTask]
        
        return NavigationView {
            EditView(task: testTask)
                .environmentObject(testViewModel)
        }
    }
}

