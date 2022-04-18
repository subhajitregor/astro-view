//
//  DailyPictureEndpoint.swift
//  astro-view
//
//  Created by Subhajit on 16/04/22.
//

struct DailyPictureEndpoint: EndPointType {
    var baseURL: String = serviceEnvironment.baseUrl
    var path: String = "/planetary/apod"
    var httpMethod: HTTPMethod = .get
    var parameters: [String : String]? {
        serviceEnvironment.apiKeyValuePair
    }
}
