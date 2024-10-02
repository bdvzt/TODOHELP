////
////  TaskService.swift
////  TODOAPP
////
////  Created by Zayata Budaeva on 02.10.2024.
////
//
//import Foundation
//import Alamofire
//
//class TaskService {
//    func getTasks(completion: @escaping ([TaskModel]) -> Void) {
//        AF.request("http://localhost:5222/api/Task/GET")
//            .responseData { response in
//                switch response.result {
//                case .success(let data):
//                    let decoder = JSONDecoder()
//                    decoder.keyDecodingStrategy = .convertFromSnakeCase // Добавьте эту строку, если нужно
//                    if let tasks = try? decoder.decode([TaskModel].self, from: data) {
//                        print("Tasks:")
//                        for task in tasks {
//                            print("- \(task.Description)")
//                        }
//                        completion(tasks)
//                    } else {
//                        completion([])
//                    }
//                case .failure(let error):
//                    print("Error fetching tasks: \(error)")
//                    completion([])
//                }
//            }
//    }
//    
//    
//    
//    func addTask(task: TaskModel, completion: @escaping (Result<Void, Error>) -> Void) {
//        let url = "http://localhost:5222/api/Task/CREATE"
//        
//        // Кодируем задачу в JSON с помощью JSONParameterEncoder
//        let encoder = JSONParameterEncoder.default
//        let parameters = ["Description": task.Description]
//        
//        AF.request(url, method: .post, parameters: parameters, encoder: encoder)
//            .responseData { response in
//                switch response.result {
//                case .success:
//                    completion(.success(()))
//                case .failure(let error):
//                    completion(.failure(error))
//                }
//            }
//        
//    }
//}
