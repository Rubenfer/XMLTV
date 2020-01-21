import Foundation

extension Date {
    static func parse(tvDate: String?) -> Date? {
        guard let tvDate = tvDate else { return nil }
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyyMMddHHmmss Z"
        return dateFormatter.date(from: tvDate)
    }
}
