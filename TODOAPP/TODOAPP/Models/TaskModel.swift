import Foundation

struct TaskModel: Identifiable, Codable{
    let id: String
    let description: String
    let isDone: Bool
    
    init(id: String = UUID().uuidString, description: String, isDone: Bool){
        self.id = id
        self.description = description
        self.isDone = isDone
    }
    
    func updateDone() -> TaskModel{
        return TaskModel(id: id, description: description, isDone: !isDone)
    }
    
    func updateDescription(newDecription: String) -> TaskModel{
        return TaskModel(id: id, description: newDecription, isDone: isDone)
    }
}


//struct TaskModel: Codable, Identifiable {
//    var id: UUID
//    var description: String
//    var isDone: Bool
//
//    func updateDone() -> TaskModel {
//        return TaskModel(id: id, description: description, isDone: !isDone)
//    }
//
//    func updateDescription(newDecription: String) -> TaskModel {
//        return TaskModel(id: id, description: newDecription, isDone: isDone)
//    }
//}
