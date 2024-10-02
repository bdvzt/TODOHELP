import Foundation

class ListViewModel: ObservableObject{
    @Published var tasks: [TaskModel] = [] {
        didSet {
            save()
        }
    }
    
    let itemsKey: String = "items_list"
    
    init(){
        getTasks()
    }
    
    func save(){
        if let encodedData = try? JSONEncoder().encode(tasks){
            UserDefaults.standard.set(encodedData, forKey: itemsKey)
        }
    }
    
    func getTasks(){
        guard
            let data = UserDefaults.standard.data(forKey: itemsKey)
        else { return }
        
        guard
            let savedItems = try? JSONDecoder().decode([TaskModel].self, from: data)
        else { return }
        
        self.tasks = savedItems
    }
    
    func delete(indexSet: IndexSet){
        tasks.remove(atOffsets: indexSet)
    }
    
    func move(from: IndexSet, to: Int){
        tasks.move(fromOffsets:  from, toOffset: to)
    }
    
    func add(description: String){
        let newItem = TaskModel(description: description, isDone: false)
        tasks.append(newItem)
    }
    
    func updateItem(task: TaskModel){
        if let index = tasks.firstIndex(where: { task_ in
                return task_.id == task.id
            }) {

            tasks[index] = task.updateDone()
        }
    }
    
    func editDescription(task: TaskModel, description: String){
        if let index = tasks.firstIndex(where: { task_ in
            return task_.description == task.description
        }) {
            
            tasks[index] = task.updateDescription(newDecription: description)
        }
    }
}

//class ListViewModel: ObservableObject {
//    @Published var tasks: [TaskModel] = [] 
//    
//    let itemsKey: String = "items_list"
//    let baseURL = "http://localhost:5222/api/Task"
//
//    init() {
//        getTasks()
//    }
//    
//    func getTasks() {
//        guard let url = URL(string: "\(baseURL)/GET") else { return }
//        
//        let task = URLSession.shared.dataTask(with: url) { data, response, error in
//            if let error = error {
//                print("Ошибка: \(error.localizedDescription)")
//                return
//            }
//            
//            guard let data = data else { return }
//            
//            do {
//                let decodedTasks = try JSONDecoder().decode([TaskModel].self, from: data)
//                DispatchQueue.main.async {
//                    self.tasks = decodedTasks
//                }
//            } catch {
//                print("Ошибка декодирования: \(error.localizedDescription)")
//            }
//        }
//        task.resume()
//    }

//    func add(description: String) {
//        let newItem = TaskModel(description: description, isDone: false)
//        guard let url = URL(string: "\(baseURL)/CREATE") else { return }
//        
//        var request = URLRequest(url: url)
//        request.httpMethod = "POST"
//        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
//        
//        do {
//            let jsonData = try JSONEncoder().encode(newItem)
//            request.httpBody = jsonData
//            
//            let task = URLSession.shared.dataTask(with: request) { data, response, error in
//                if let error = error {
//                    print("Ошибка: \(error.localizedDescription)")
//                    return
//                }
//                
//                // Обновляем локальный массив задач
//                DispatchQueue.main.async {
//                    self.tasks.append(newItem)
//                }
//            }
//            task.resume()
//        } catch {
//            print("Ошибка при кодировании: \(error.localizedDescription)")
//        }
//    }
//
//    func delete(indexSet: IndexSet) {
//        guard let index = indexSet.first else { return }
//        let taskToDelete = tasks[index]
//        
//        guard let url = URL(string: "\(baseURL)/DELETE") else { return }
//        
//        var request = URLRequest(url: url)
//        request.httpMethod = "DELETE"
//        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
//        
//        do {
//            let jsonData = try JSONEncoder().encode(taskToDelete)
//            request.httpBody = jsonData
//            
//            let task = URLSession.shared.dataTask(with: request) { data, response, error in
//                if let error = error {
//                    print("Ошибка: \(error.localizedDescription)")
//                    return
//                }
//                
//                DispatchQueue.main.async {
//                    self.tasks.remove(atOffsets: indexSet)
//                }
//            }
//            task.resume()
//        } catch {
//            print("Ошибка при кодировании: \(error.localizedDescription)")
//        }
//    }
//
//    func updateItem(task: TaskModel) {
//        guard let url = URL(string: "\(baseURL)/UPDATE") else { return }
//        
//        var request = URLRequest(url: url)
//        request.httpMethod = "PATCH"
//        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
//        
//        do {
//            let jsonData = try JSONEncoder().encode(task)
//            request.httpBody = jsonData
//            let taskUpdate = URLSession.shared.dataTask(with: request) { data, response, error in
//                            if let error = error {
//                                print("Ошибка: \(error.localizedDescription)")
//                                return
//                            }
//                            
//                            DispatchQueue.main.async {
//                                if let index = self.tasks.firstIndex(where: { $0.id == task.id }) {
//                                    self.tasks[index] = task.updateDone() // или любая другая логика обновления
//                                }
//                            }
//                        }
//                        taskUpdate.resume()
//                    } catch {
//                        print("Ошибка при кодировании: \(error.localizedDescription)")
//                    }
//                }

                // Другие методы...
//            }
