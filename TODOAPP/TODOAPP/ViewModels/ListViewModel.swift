import Foundation
import SwiftUI

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
                        print("Полученные задачи: \(tasks)")
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
        if let jsonData = try? encoder.encode(task) { 
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
                self.getTasks()
            }.resume()
            
        } else {
            completion(.failure(NSError(domain: "EncodingError", code: 0, userInfo: nil)))
        }
    }
    
    func deleteTask(task: TaskModelDelete, completion: @escaping (Result<Void, Error>) -> Void) {
        guard let url = URL(string: "\(localhost)/DELETE") else {
            completion(.failure(NSError(domain: "InvalidURL", code: 0, userInfo: nil)))
            return
        }
        
        let encoder = JSONEncoder()
        if let jsonData = try? encoder.encode(task) {
            var request = URLRequest(url: url)
            request.httpMethod = "DELETE"
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            request.httpBody = jsonData
            
            URLSession.shared.dataTask(with: request) { data, response, error in
                if let error = error {
                    completion(.failure(error))
                    return
                }
                
                completion(.success(()))
                self.getTasks()
            }.resume()
        }
    }
    
    
    func updateTask(task: TaskModelUpdate) {
        guard let url = URL(string: "\(localhost)/COMPLETED") else {
            return
        }
        
        let encoder = JSONEncoder()
        if let jsonData = try? encoder.encode(task) {
            var request = URLRequest(url: url)
            request.httpMethod = "PATCH"
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            request.httpBody = jsonData
            
            URLSession.shared.dataTask(with: request) { data, response, error in
                if let error = error {
                    return
                }
                self.getTasks()
            }.resume()
        }
    }
    
    func editTask(task: TaskModelEdit) {
        guard let url = URL(string: "\(localhost)/UPDATE") else {
            return
        }
        
        let encoder = JSONEncoder()
        if let jsonData = try? encoder.encode(task) {
            var request = URLRequest(url: url)
            request.httpMethod = "PATCH"
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            request.httpBody = jsonData
            
            URLSession.shared.dataTask(with: request) { data, response, error in
                if let error = error {
                    return
                }
                self.getTasks()
            }.resume()
        }
    }
}
