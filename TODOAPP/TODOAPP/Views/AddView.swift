import SwiftUI
import Foundation

import Alamofire

struct AddView: View {
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var listViewModel: ListViewModel
    
    @State private var textFieldText: String = ""
    @State private var alertText: String = "Your task must have at least 1 symbol"
    @State private var isAlert: Bool = false
    
    let bg = Color(UIColor(red: 0.9, green: 0.9, blue: 0.9, alpha: 1.0))
    
    var body: some View {
        ScrollView {
            VStack {
                TextField("Type the task", text: $textFieldText)
                    .padding(.horizontal)
                    .frame(height: 80)
                    .background(bg)
                    .cornerRadius(20)
                Button(action: addTask) {
                    Text("Add")
                        .foregroundColor(.white)
                        .font(.headline)
                        .frame(height: 60)
                        .frame(maxWidth: .infinity)
                        .background(Color.pink)
                        .cornerRadius(20)
                }
            }
            .padding(14)
        }
        .navigationTitle("Add a task")
        .alert(isPresented: $isAlert) {
            Alert(title: Text(alertText), dismissButton: .default(Text("OK")) {
                textFieldText = ""
            })
        }
    }
    
    func addTask() {
            if textFieldText.isEmpty {
                isAlert = true
                return
            }
            
            let newTask = TaskModelAdd(description: textFieldText)
            listViewModel.addTask(task: newTask) { result in
                switch result {
                case .success:
                    presentationMode.wrappedValue.dismiss()
                case .failure(_):
                    print("Error adding task: (error)")
                    // Обработайте ошибку, например, покажите уведомление пользователю
                }
            }
        presentationMode.wrappedValue.dismiss()
        }



    
//    func addTask() {
//        if check() {
//            // Создаем новую задачу (id теперь не нужен)
//            let newTask = TaskModel(Description: textFieldText, isDone: false)
//
//            // Вызываем функцию для создания задачи на бэкенде
//            TaskService().addTask(task: newTask) { result in
//                switch result {
//                case .success:
//                    // Задача успешно добавлена, закрываем представление
//                    presentationMode.wrappedValue.dismiss()
//                case .failure(let error):
//                    // Произошла ошибка при добавлении задачи
//                    alertText = "Error adding task: \(error.localizedDescription)"
//                    isAlert = true
//                }
//            }
//        } else {
//            // ...
//        }
//    }
    
//    func addTask() {
//        if check() {
//            listViewModel.add(description: textFieldText)
//            presentationMode.wrappedValue.dismiss()
//        } else {
//            print("Invalid task description")
//        }
//    }
    
    func check() -> Bool {
        if textFieldText.count < 1 {
            isAlert = true // Устанавливаем isAlert в true для показа оповещения
            return false
        }
        return true
    }
}

struct AddView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView{
            AddView()
        }
        .environmentObject(ListViewModel())
    }
}
