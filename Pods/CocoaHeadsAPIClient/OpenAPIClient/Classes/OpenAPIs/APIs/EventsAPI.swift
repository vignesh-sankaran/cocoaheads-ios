//
// EventsAPI.swift
//
// Generated by openapi-generator
// https://openapi-generator.tech
//

import Alamofire
import Foundation

open class EventsAPI {
    /**

     - parameter eventSlug: (path) slug of the event
     - parameter completion: completion handler to receive the data and the error objects
     */
    open class func getEvent(eventSlug: String, completion: @escaping ((_ data: InlineResponse2001?, _ error: Error?) -> Void)) {
        getEventWithRequestBuilder(eventSlug: eventSlug).execute { (response, error) -> Void in
            completion(response?.body, error)
        }
    }

    /**
     - GET /evenets/{eventSlug}
     - Fetch an individual event
     - parameter eventSlug: (path) slug of the event
     - returns: RequestBuilder<InlineResponse2001>
     */
    open class func getEventWithRequestBuilder(eventSlug: String) -> RequestBuilder<InlineResponse2001> {
        var path = "/evenets/{eventSlug}"
        let eventSlugPreEscape = "\(eventSlug)"
        let eventSlugPostEscape = eventSlugPreEscape.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed) ?? ""
        path = path.replacingOccurrences(of: "{eventSlug}", with: eventSlugPostEscape, options: .literal, range: nil)
        let URLString = OpenAPIClientAPI.basePath + path
        let parameters: [String: Any]? = nil

        let url = URLComponents(string: URLString)

        let requestBuilder: RequestBuilder<InlineResponse2001>.Type = OpenAPIClientAPI.requestBuilderFactory.getBuilder()

        return requestBuilder.init(method: "GET", URLString: (url?.string ?? URLString), parameters: parameters, isBody: false)
    }

    /**

     - parameter completion: completion handler to receive the data and the error objects
     */
    open class func getEvents(completion: @escaping ((_ data: InlineResponse200?, _ error: Error?) -> Void)) {
        getEventsWithRequestBuilder().execute { (response, error) -> Void in
            completion(response?.body, error)
        }
    }

    /**
     - GET /events
     - Fetch list of published, upcoming events
     - returns: RequestBuilder<InlineResponse200>
     */
    open class func getEventsWithRequestBuilder() -> RequestBuilder<InlineResponse200> {
        let path = "/events"
        let URLString = OpenAPIClientAPI.basePath + path
        let parameters: [String: Any]? = nil

        let url = URLComponents(string: URLString)

        let requestBuilder: RequestBuilder<InlineResponse200>.Type = OpenAPIClientAPI.requestBuilderFactory.getBuilder()

        return requestBuilder.init(method: "GET", URLString: (url?.string ?? URLString), parameters: parameters, isBody: false)
    }
}
