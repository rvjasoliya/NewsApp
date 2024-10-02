//
//  APIService.swift
//  DunnMetal
//
//  Created by chanaka kasun bandara on 11/26/18.
//  Copyright © 2018 Elegant Media. All rights reserved.
//

import Foundation

struct API {
    
    static let APIKey = "716e09be766b4421bfcff16c59a9b299"
    static var BaseURL = "https://newsapi.org/v2"
    
}

// MARK: - Router
enum Router {
    
    case topHeadlines(queryData: TopHeadlinesRequestData?)
    
    // MARK: - Path
    internal var path: String {
        switch self {
        case .topHeadlines(let queryData):
            let query = getQueryParts(router: self, object: queryData as Any)
            return "/top-headlines\(query)"
        }
    }

    // request String url
    static func urlString(router: Router) -> String {
        return "\(API.BaseURL + router.path)"
    }
    
    func getQueryParts(router: Router, object: Any) -> String {
        switch router {
        case .topHeadlines:
            var query: String = ""
            
            if let _object = object as? TopHeadlinesRequestData {
                
                let apiKey = _object.apiKey
                query.append("?apiKey=\(apiKey)")
                
                if let country = _object.country {
                    query.append("&country=\(country)")
                }
                
                if let category = _object.category {
                    query.append("&category=\(category)")
                }
                
                if let pageSize = _object.pageSize {
                    query.append("&pageSize=\(pageSize)")
                }
                
                if let page = _object.page {
                    query.append("&page=\(page)")
                }
                
                if let q = _object.q {
                    query.append("&q=\(q)")
                }
            }
            return query
        }
    }
    
}

struct TopHeadlinesRequestData {
    
    var apiKey: String
    var country: String?
    var category: String?
    var pageSize: Int?
    var page: Int?
    var q: String?
    
    init(apiKey: String, country: String?, category: String?, pageSize: Int?, page: Int?, q: String?) {
        self.apiKey = apiKey
        self.country = country
        self.category = category
        self.pageSize = pageSize
        self.page = page
        self.q = q
    }
}
