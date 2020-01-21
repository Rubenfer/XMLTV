import Foundation

public struct TVProgram {
    public let start: Date?
    public let stop: Date?
    public let channel: TVChannel
    public let title: String?
    public let description: String?
    public let credits: [String:String]
    public let date: String?
    public let categories: [String]
    public let country: String?
    public let episode: String?
    public let icon: String?
    public let rating: String?
}

