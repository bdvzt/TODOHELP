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

    init(id: UUID, description: String, status: Bool) {
        self.id = id
        self.description = description
        self.status = status
    }
}

struct TaskModelAdd: Encodable {
    let description: String

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(description, forKey: .description)
    }

    enum CodingKeys: String, CodingKey {
        case description
    }
}

struct TaskModelEdit: Encodable {
    let id: UUID
    let description: String

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(description, forKey: .description)
    }

    enum CodingKeys: String, CodingKey {
        case id
        case description
    }
}

struct TaskModelDelete: Encodable {
    let id: UUID

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
    }

    enum CodingKeys: String, CodingKey {
        case id
    }
}

struct TaskModelUpdate: Encodable {
    let id: UUID
    let status: Bool

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(status, forKey: .status)
    }

    enum CodingKeys: String, CodingKey {
        case id
        case status
    }
}
