import Foundation
import LightXMLParser

private extension XML {
    func children(name: String) -> [XML] {
        return children.filter { $0.name == name }
    }
}

public class XMLTV {
    
    private let xml: XML
    
    public init(data: Data) throws {
        self.xml = try XML(data: data)
    }
    
    public func getChannels() -> [TVChannel] {
        var channels: [TVChannel] = []
        
        let xmlChannels = xml.children(name: "channel")
        xmlChannels.forEach { channel in
            if let id = channel.attributes["id"] {
                let name = channel.children(name: "display-name").first?.value
                let url = channel.children(name: "url").first?.value
                let iconSrc = channel.children(name: "icon").first?.attributes["src"]
                channels.append(TVChannel(id: id, name: name, url: url, icon: iconSrc))
            }
        }
        
        return channels
    }
    
    public func getPrograms(channel: TVChannel) -> [TVProgram] {
        var programs: [TVProgram] = []
        
        let xmlPrograms = xml.children.filter { $0.name == "programme" && $0.attributes["channel"] == channel.id }
        xmlPrograms.forEach { program in
            let startDate = Date.parse(tvDate: program.attributes["start"])
            let stopDate = Date.parse(tvDate: program.attributes["stop"])
            let title = program.children(name: "title").first?.value
            let description = program.children(name: "desc").first?.value
            let icon = program.children(name: "icon").first?.attributes["src"]
            let rating = program.children(name: "star-rating").first?.children(name: "value").first?.value
            let date = program.children(name: "date").first?.value
            let episode = program.children(name: "episode-num").first?.value
            let categories = program.children(name: "category").map { $0.value }
            let country = program.children(name: "country").first?.value
            let credits = program.children(name: "credits").first?.children.reduce([String:String]()) { dict, credit -> [String:String] in
                var dict = dict
                dict[credit.name] = credit.value
                return dict
                } ?? [:]
            programs.append(TVProgram(start: startDate, stop: stopDate, channel: channel, title: title, description: description, credits: credits, date: date, categories: categories, country: country, episode: episode, icon: icon, rating: rating))
        }
        
        return programs
    }
    
}
