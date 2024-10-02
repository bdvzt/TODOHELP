import Foundation
import SwiftUI

/*class ListViewModel: ObservableObject{
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
*/


class ListViewModel: ObservableObject {
    @Published var tasks: [TaskModel] = []

    private let localhost = "http://localhost:5222/api/Task"

    init() {
        getTasks()
    }

    func getTasks() {
        guard let url = URL(string: "\(localhost)/GET") else {
            return
        }

        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print("Ошибка при выполнении: \(error.localizedDescription)")
                return
            }

            if let data = data {
                do {
                    let decoder = JSONDecoder()
                    decoder.keyDecodingStrategy = .convertFromSnakeCase
                    if let tasks = try? decoder.decode([TaskModel].self, from: data) {
                        print("Полученные карточки: \(tasks)")
                        DispatchQueue.main.async {
                            self.tasks = tasks
                        }
                    } else {
                        print("Ошибка декодирования JSON")
                    }
                } catch {
                    print("Ошибка: \(error)")
                }
            }
        }.resume()
    }

    func addTask(task: TaskModelAdd, completion: @escaping (Result<Void, Error>) -> Void) {
        guard let url = URL(string: "\(localhost)/CREATE") else {
            completion(.failure(NSError(domain: "InvalidURL", code: 0, userInfo: nil)))
            return
        }
        
        let encoder = JSONEncoder()
        if let jsonData = try? encoder.encode(task) { // Теперь работает
            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            request.httpBody = jsonData
            
            URLSession.shared.dataTask(with: request) { data, response, error in
                if let error = error {
                    completion(.failure(error))
                    return
                }
               
                completion(.success(()))
            }.resume()
            
        } else {
            completion(.failure(NSError(domain: "EncodingError", code: 0, userInfo: nil)))
        }
        getTasks()
    }
}
