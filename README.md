# XMLTV

XMLTV is a Swift package which allows you to parse XML files using the EPG XMLTV structure.

## Usage
Add XMLTV to your project using Swift Package Manager.

XMLTV provides two structs representing channels and programs.

```swift
public struct TVChannel {
    public let id: String
    public let name: String?
    public let url: String?
    public let icon: String?
}

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
```

To parse files, you need to create an XMLTV object using the file data. Then you can use `getChannels() -> [TVChannel]` and `getPrograms(channel:) -> [TVProgram]` to get the information.