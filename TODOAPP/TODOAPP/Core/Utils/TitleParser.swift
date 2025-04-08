//
//  TitleParser.swift
//  TODOAPP
//
//  Created by Zayata Budaeva on 07.04.2025.
//

import Foundation

func parseTitle(_ title: String) -> (title: String, deadline: Date?, priority: TaskPriority) {
    var resultTitle = title
    let priority = extractPriority(from: &resultTitle)
    let deadline = extractDeadline(from: &resultTitle)

    return (
        title: resultTitle.trimmingCharacters(in: .whitespaces),
        deadline: deadline,
        priority: priority
    )
}

private func extractPriority(from title: inout String) -> TaskPriority {
    if let matchRange = title.range(of: "!([1-4])", options: .regularExpression) {
        let match = String(title[matchRange])
        title.removeSubrange(matchRange)

        switch match {
        case "!1": return .critical
        case "!2": return .high
        case "!3": return .medium
        case "!4": return .low
        default: break
        }
    }
    return .medium
}

private func extractDeadline(from title: inout String) -> Date? {
    let regex = try! NSRegularExpression(pattern: "!before (\\d{2}[.-]\\d{2}[.-]\\d{4})")

    if let match = regex.firstMatch(in: title, range: NSRange(title.startIndex..., in: title)),
       let dateRange = Range(match.range(at: 1), in: title) {

        let dateString = String(title[dateRange])
        title.removeSubrange(Range(match.range(at: 0), in: title)!)

        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.yyyy"

        return formatter.date(from: dateString) ?? {
            formatter.dateFormat = "dd-MM-yyyy"
            return formatter.date(from: dateString)
        }()
    }

    return nil
}
