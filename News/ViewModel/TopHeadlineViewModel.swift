//
//  ViewModel.swift
//  News
//
//  Created by iMac on 23/01/24.
//

import Foundation
import UIKit

typealias actionHandler = (_ status: Bool, _ message: String) -> ()

class TopHeadlineViewModel {
    
    var category = "business"
    var categories = ["business", "entertainment", "general", "health", "science", "sports", "technology"]
    var articleArray: [Articles] = []
    
    func netRequestForGetTopHeadlines(queryData: TopHeadlinesRequestData?, completion: @escaping actionHandler) {
        
        let dataSource = URLDataRequest(url:  Router.urlString(router: .topHeadlines(queryData: queryData)), param: nil, method: .get)
        //start progress
        showLoading()
        JSONRequest(dataSource: dataSource).requestJSONObject { jsonResponse, message in
            //hide progress
            dissmissLoader()
            guard let json = jsonResponse else {
                completion(false, message ?? "unkown_error")
                return
            }
            let topHeadline: TopHeadline? = TopHeadline.mapTopHeadlineData(json: json)
            self.articleArray = topHeadline?.articles ?? []
            
            completion(true, "Notes succesfully fetched")
        }
    }
    
}
