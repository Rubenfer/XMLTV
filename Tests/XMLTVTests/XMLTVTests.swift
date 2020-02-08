import XCTest
@testable import XMLTV

final class XMLTVTests: XCTestCase {
    
    let xmltvExample = """
    <tv>
        <channel id="Example">
            <display-name>Example channel</display-name>
            <url>https://example.com</url>
        </channel>
        <programme channel="Example" start="20200121103000 +0100" stop="20200121110000 +0100">
            <title>First</title>
            <desc>This is an example</desc>
            <category>CAT1</category>
            <category>CAT2</category>
            <icon src="https://example.com" />
            <credits>
                <p1>P1</p1>
                <p2>P2</p2>
            </credits>
            <country>Spain</country>
            <episode-num>S1 E1</episode-num>
            <date>2020</date>
            <star-rating>
                <value>5/5</value>
            </star-rating>
        </programme>
    </tv>
    """
    
    func testChannel() {
        let data = xmltvExample.data(using: .utf8)!
        let xmltv = try? XMLTV(data: data)
        
        XCTAssertNotNil(xmltv)
        
        let channels = xmltv!.getChannels()
        XCTAssert(channels.count == 1)
        
        let channel = channels[0]
        XCTAssert(channel.name == "Example channel")
        XCTAssert(channel.id == "Example")
        XCTAssert(channel.url == "https://example.com")
        XCTAssert(channel.icon == nil)
    }
    
    func testProgram() {
        let data = xmltvExample.data(using: .utf8)!
        let xmltv = try? XMLTV(data: data)
        
        XCTAssertNotNil(xmltv)
        
        let channel = xmltv!.getChannels()[0]
        let programs = xmltv!.getPrograms(channel: channel)
        XCTAssert(programs.count == 1)
        
        let program = programs[0]
        XCTAssert(program.channel.id == channel.id)
        XCTAssert(program.start == Date.parse(tvDate: "20200121103000 +0100"))
        XCTAssert(program.stop == Date.parse(tvDate: "20200121110000 +0100"))
        XCTAssert(program.title == "First")
        XCTAssert(program.description == "This is an example")
        XCTAssert(program.categories.count == 2)
        XCTAssert(program.categories[0] == "CAT1")
        XCTAssert(program.categories[1] == "CAT2")
        XCTAssert(program.icon == "https://example.com")
        XCTAssert(program.credits.count == 2)
        XCTAssert(program.credits["p1"] == "P1")
        XCTAssert(program.credits["p2"] == "P2")
        XCTAssert(program.country == "Spain")
        XCTAssert(program.episode == "S1 E1")
        XCTAssert(program.date == "2020")
        XCTAssert(program.rating == "5/5")
    }

    static var allTests = [
        ("testChannel", testChannel),
        ("testProgram", testProgram),
    ]
}
