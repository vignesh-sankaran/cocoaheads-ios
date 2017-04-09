// Models.swift
//
// Generated by swagger-codegen
// https://github.com/swagger-api/swagger-codegen
//

import Foundation

protocol JSONEncodable {
    func encodeToJSON() -> Any
}

public enum ErrorResponse : Error {
    case Error(Int, Data?, Error)
}

open class Response<T> {
    open let statusCode: Int
    open let header: [String: String]
    open let body: T?

    public init(statusCode: Int, header: [String: String], body: T?) {
        self.statusCode = statusCode
        self.header = header
        self.body = body
    }

    public convenience init(response: HTTPURLResponse, body: T?) {
        let rawHeader = response.allHeaderFields
        var header = [String:String]()
        for (key, value) in rawHeader {
            header[key as! String] = value as? String
        }
        self.init(statusCode: response.statusCode, header: header, body: body)
    }
}

private var once = Int()
class Decoders {
    static fileprivate var decoders = Dictionary<String, ((AnyObject) -> AnyObject)>()

    static func addDecoder<T>(clazz: T.Type, decoder: @escaping ((AnyObject) -> T)) {
        let key = "\(T.self)"
        decoders[key] = { decoder($0) as AnyObject }
    }

    static func decode<T>(clazz: T.Type, discriminator: String, source: AnyObject) -> T {
        let key = discriminator;
        if let decoder = decoders[key] {
            return decoder(source) as! T
        } else {
            fatalError("Source \(source) is not convertible to type \(clazz): Maybe swagger file is insufficient")
        }
    }

    static func decode<T>(clazz: [T].Type, source: AnyObject) -> [T] {
        let array = source as! [AnyObject]
        return array.map { Decoders.decode(clazz: T.self, source: $0) }
    }

    static func decode<T, Key: Hashable>(clazz: [Key:T].Type, source: AnyObject) -> [Key:T] {
        let sourceDictionary = source as! [Key: AnyObject]
        var dictionary = [Key:T]()
        for (key, value) in sourceDictionary {
            dictionary[key] = Decoders.decode(clazz: T.self, source: value)
        }
        return dictionary
    }

    static func decode<T>(clazz: T.Type, source: AnyObject) -> T {
        initialize()
        if T.self is Int32.Type && source is NSNumber {
            return source.int32Value as! T;
        }
        if T.self is Int64.Type && source is NSNumber {
            return source.int64Value as! T;
        }
        if T.self is UUID.Type && source is String {
            return UUID(uuidString: source as! String) as! T
        }
        if source is T {
            return source as! T
        }
        if T.self is Data.Type && source is String {
            return Data(base64Encoded: source as! String) as! T
        }

        let key = "\(T.self)"
        if let decoder = decoders[key] {
           return decoder(source) as! T
        } else {
            fatalError("Source \(source) is not convertible to type \(clazz): Maybe swagger file is insufficient")
        }
    }

    static func decodeOptional<T>(clazz: T.Type, source: AnyObject?) -> T? {
        if source is NSNull {
            return nil
        }
        return source.map { (source: AnyObject) -> T in
            Decoders.decode(clazz: clazz, source: source)
        }
    }

    static func decodeOptional<T>(clazz: [T].Type, source: AnyObject?) -> [T]? {
        if source is NSNull {
            return nil
        }
        return source.map { (someSource: AnyObject) -> [T] in
            Decoders.decode(clazz: clazz, source: someSource)
        }
    }

    static func decodeOptional<T, Key: Hashable>(clazz: [Key:T].Type, source: AnyObject?) -> [Key:T]? {
        if source is NSNull {
            return nil
        }
        return source.map { (someSource: AnyObject) -> [Key:T] in
            Decoders.decode(clazz: clazz, source: someSource)
        }
    }

    private static var __once: () = {
        let formatters = [
            "yyyy-MM-dd",
            "yyyy-MM-dd'T'HH:mm:ssZZZZZ",
            "yyyy-MM-dd'T'HH:mm:ss.SSSZZZZZ",
            "yyyy-MM-dd'T'HH:mm:ss'Z'",
            "yyyy-MM-dd'T'HH:mm:ss.SSS",
            "yyyy-MM-dd HH:mm:ss"
        ].map { (format: String) -> DateFormatter in
            let formatter = DateFormatter()
            formatter.dateFormat = format
            return formatter
        }
        // Decoder for Date
        Decoders.addDecoder(clazz: Date.self) { (source: AnyObject) -> Date in
           if let sourceString = source as? String {
                for formatter in formatters {
                    if let date = formatter.date(from: sourceString) {
                        return date
                    }
                }
            }
            if let sourceInt = source as? Int64 {
                // treat as a java date
                return Date(timeIntervalSince1970: Double(sourceInt / 1000) )
            }
            fatalError("formatter failed to parse \(source)")
        } 

        // Decoder for [Event]
        Decoders.addDecoder(clazz: [Event].self) { (source: AnyObject) -> [Event] in
            return Decoders.decode(clazz: [Event].self, source: source)
        }
        // Decoder for Event
        Decoders.addDecoder(clazz: Event.self) { (source: AnyObject) -> Event in
            let sourceDictionary = source as! [AnyHashable: Any]

            let instance = Event()
            instance.address = Decoders.decodeOptional(clazz: String.self, source: sourceDictionary["address"] as AnyObject?)
            instance.addressDisplay = Decoders.decodeOptional(clazz: String.self, source: sourceDictionary["address_display"] as AnyObject?)
            instance.contact = Decoders.decodeOptional(clazz: String.self, source: sourceDictionary["contact"] as AnyObject?)
            instance.contactName = Decoders.decodeOptional(clazz: String.self, source: sourceDictionary["contact_name"] as AnyObject?)
            instance.endsAt = Decoders.decodeOptional(clazz: String.self, source: sourceDictionary["ends_at"] as AnyObject?)
            if let eventType = sourceDictionary["event_type"] as? String { 
                instance.eventType = Event.EventType(rawValue: (eventType))
            }
            
            instance.lat = Decoders.decodeOptional(clazz: Double.self, source: sourceDictionary["lat"] as AnyObject?)
            instance.lng = Decoders.decodeOptional(clazz: Double.self, source: sourceDictionary["lng"] as AnyObject?)
            instance.location = Decoders.decodeOptional(clazz: String.self, source: sourceDictionary["location"] as AnyObject?)
            instance.locationLink = Decoders.decodeOptional(clazz: String.self, source: sourceDictionary["location_link"] as AnyObject?)
            instance.startsAt = Decoders.decodeOptional(clazz: String.self, source: sourceDictionary["starts_at"] as AnyObject?)
            instance.subtitle = Decoders.decodeOptional(clazz: String.self, source: sourceDictionary["subtitle"] as AnyObject?)
            instance.tickets = Decoders.decodeOptional(clazz: String.self, source: sourceDictionary["tickets"] as AnyObject?)
            instance.title = Decoders.decodeOptional(clazz: String.self, source: sourceDictionary["title"] as AnyObject?)
            instance.url = Decoders.decodeOptional(clazz: String.self, source: sourceDictionary["url"] as AnyObject?)
            return instance
        }


        // Decoder for [EventsResponse]
        Decoders.addDecoder(clazz: [EventsResponse].self) { (source: AnyObject) -> [EventsResponse] in
            return Decoders.decode(clazz: [EventsResponse].self, source: source)
        }
        // Decoder for EventsResponse
        Decoders.addDecoder(clazz: EventsResponse.self) { (source: AnyObject) -> EventsResponse in
            let sourceDictionary = source as! [AnyHashable: Any]

            let instance = EventsResponse()
            instance.events = Decoders.decodeOptional(clazz: Array.self, source: sourceDictionary["events"] as AnyObject?)
            return instance
        }
    }()

    static fileprivate func initialize() {
        _ = Decoders.__once
    }
}