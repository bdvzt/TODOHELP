import Foundation

struct TaskModel: Identifiable, Codable {
    let id: UUID
    let description: String
    let status: Bool

    enum CodingKeys: String, CodingKey {
        case id = "id"
        case description = "description"
        case status = "status"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decode(UUID.self, forKey: .id)
        description = try values.decode(String.self, forKey: .description)
        status = try values.decode(Bool.self, forKey: .status)
    }

    // Добавить инициализатор для TaskModel
    init(id: UUID, description: String, status: Bool) {
        self.id = id
        self.description = description
        self.status = status
    }
}

struct TaskModelAdd: Encodable {
    let description: String

    // Add the encode(to:) method
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(description, forKey: .description)
    }

    // Add the CodingKeys enum
    enum CodingKeys: String, CodingKey {
        case description
    }
}

struct TaskModelDelete: Encodable {
    let id: UUID

    // Add the encode(to:) method
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
    }

    // Add the CodingKeys enum
    enum CodingKeys: String, CodingKey {
        case id
    }
}



//struct TaskModel: Identifiable, Codable{
//    let Id: String
//    let Description: String
//    let Status: Bool
//    
//    let id: String = UUID().uuidString
//    
//    enum CodingKeys: String, CodingKey {
//        case Id = "Id"
//        case Description = "Description"
//        case Status = "Status"
//    }
//    
//    init(Id: String, Description: String, Status: Bool) {
//        self.Id = Id
//        self.Description = Description
//        self.Status = Status
//    }
//}
    
    
//struct TaskModel: Identifiable, Codable {
//    let Description: String
//    let Status: Bool
//    let Id: UUID // Изменено на UUID
//
//
//    enum CodingKeys: String, CodingKey {
//        case Description = "Description"
//        case Status = "Status"
//        case Id = "Id" // Используйте Id
//    }
//
//    // Инициализатор для декодирования из JSON
//    init(from decoder: Decoder) throws {
//        let values = try decoder.container(keyedBy: CodingKeys.self)
//        Description = try values.decode(String.self, forKey: .Description)
//        Status = try values.decode(Bool.self, forKey: .Status)
//        Id = try values.decode(UUID.self, forKey: .Id) // Изменено на UUID
//    }
//
//    // Добавить инициализатор для TaskModel
//    init(Description: String, Status: Bool, Id: UUID) {
//        self.Description = Description
//        self.Status = Status
//        self.Id = Id
//    }
//}

//    func updateDone() -> TaskModel{
//        return TaskModel(id: id, description: description, isDone: !isDone)
//    }
//    
//    func updateDescription(newDecription: String) -> TaskModel{
//        return TaskModel(id: id, description: newDecription, isDone: isDone)
//    }

